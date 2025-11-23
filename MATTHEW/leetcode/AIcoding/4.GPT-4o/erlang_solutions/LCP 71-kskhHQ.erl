-module(solution).
-export([trap/1]).

trap(Height) ->
    trap(Height, 0, 0, 0).

trap([], _, Acc, _) -> Acc;
trap([H | T], LeftMax, Acc, RightMax) ->
    NewLeftMax = max(LeftMax, H),
    NewRightMax = RightMax + H,
    trap(T, NewLeftMax, Acc + max(0, NewLeftMax - H), NewRightMax).

max(A, B) when A > B -> A;
max(_, B) -> B.