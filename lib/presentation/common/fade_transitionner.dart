import 'package:flutter/material.dart';

class FadeTransitionner extends StatelessWidget {
  final Widget child;
  final bool hasScale;
  final Duration duration;

  const FadeTransitionner(
    this.child, {
    Key? key,
    this.hasScale = false,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Interval(
        0.3,
        1,
        curve: Curves.easeIn,
      ),
      switchOutCurve: Interval(
        0.7,
        1,
        curve: Curves.easeOut,
      ),
      transitionBuilder: (Widget child, Animation<double> animation) {
        Widget fadeChild;
        if (hasScale && animation.status == AnimationStatus.dismissed) {
          // current page includes an additional scale transition
          fadeChild = ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1).animate(animation),
            child: child,
          );
        } else {
          // previous page just fades out
          fadeChild = child;
        }

        return FadeTransition(
          opacity: animation,
          child: fadeChild,
        );
      },
      child: child,
    );
  }
}
