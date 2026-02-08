-module(solution).
-export([trap/1]).

trap(Height) ->
    trap(Height, 0, 0, 0, []).

trap([], _Left, _Right, _Max, _Stack) ->
    0;
trap([H | T], Left, Right, Max, Stack) ->
    case H of
        H when H < Max ->
            trap(T, Left, Right, Max, [H | Stack]);
        _ ->
            NewMax = max(Max, H),
            NewLeft = Left + 1,
            trap(T, NewLeft, Right, NewMax, [])
    end.