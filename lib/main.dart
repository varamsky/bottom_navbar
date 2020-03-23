import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Nav Bar',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool isDark;
  List<bool> showList = [true, false, false, false];
  List<Color> lightColorList = [
    Colors.redAccent,
    Colors.amber,
    Colors.greenAccent,
    Colors.deepPurple
  ];
  List<Color> darkColorList = [
    Color(0xff03B065),
    Colors.redAccent,
    Colors.tealAccent,
    Colors.amberAccent,
  ];
  Color backgroundColor;

  @override
  void initState() {
    super.initState();

    isDark = false;
    backgroundColor = (isDark) ? darkColorList[0] : lightColorList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      appBar: AppBar(
        backgroundColor: (isDark) ? Color(0xff18141A) : Colors.blueAccent,
        title: Text('Bottom Nav Bar'),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        color: backgroundColor,
        child: toggleButton(),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: (isDark) ? Color(0xff18141A) : Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          navBarItem(Icons.home, 'Home', 0),
          navBarItem(Icons.add, 'Add', 1),
          navBarItem(Icons.search, 'Search', 2),
          navBarItem(Icons.person_outline, 'Profile', 3),
        ],
      ),
    );
  }

  Widget navBarItem(IconData icon, String text, int show) {
    return InkWell(
      onTap: () {
        setState(() {
          for (int i = 0; i < showList.length; i++) {
            print('${showList[i]}');
            showList[i] = false;
          }
          showList[show] = true;
          backgroundColor =
              (isDark) ? darkColorList[show] : lightColorList[show];

          print('\n\n\n');
          for (int i = 0; i < showList.length; i++) {
            print('${showList[i]}');
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: (isDark)
              ? ((showList[show])
                  ? darkColorList[show].withOpacity(0.2)
                  : Color(0xff18141A))
              : ((showList[show])
                  ? lightColorList[show].withOpacity(0.2)
                  : Colors.white),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              color: (isDark) ? darkColorList[show] : lightColorList[show],
            ),
            SizedBox(
              width: 5.0,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              vsync: this,
              child: Text(
                (showList[show]) ? text : '',
                style: TextStyle(
                    color:
                        (isDark) ? darkColorList[show] : lightColorList[show]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toggleButton() {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isDark = !isDark;
          });
        },
        child: AnimatedContainer(
          width: 100.0,
          height: 40.0,
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: (isDark) ? Colors.greenAccent[100] : Colors.redAccent[100],
          ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                left: (isDark) ? 60.0 : 5.0,
                top: 3.0,
                duration: Duration(milliseconds: 500),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: (isDark)
                      ? Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 35.0,
                          key: UniqueKey(),
                        )
                      : Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 35.0,
                          key: UniqueKey(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
