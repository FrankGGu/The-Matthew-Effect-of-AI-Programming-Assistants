-module(trapping_rain_water).
-export([trap/1]).

trap(Height) ->
    trap(Height, 0, 0, 0, []).

trap([], _Left, _Right, _Water, _Stack) ->
    Water;
trap([H | T], Left, Right, Water, Stack) ->
    case Stack of
        [] ->
            trap(T, H, Right, Water, [H]);
        [Top | _] when H < Top ->
            trap(T, Left, Right, Water, [H | Stack]);
        [Top | _] when H >= Top ->
            NewWater = Water + (min(Left, H) - Top),
            trap([H | T], Left, Right, NewWater, tl(Stack))
    end.