-module(btree_tilt).
-export([findTilt/1]).

findTilt(null) -> 0;
findTilt({NodeVal, Left, Right}) ->
    LeftSum = findTilt(Left),
    RightSum = findTilt(Right),
    abs(LeftSum - RightSum) + findTilt(Left) + findTilt(Right).

abs(X) when X >= 0 -> X;
abs(X) -> -X.