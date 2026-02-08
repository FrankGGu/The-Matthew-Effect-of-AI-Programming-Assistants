-module(burst_balloons).
-export([burst/1]).

burst(Balloons) ->
    N = length(Balloons),
    DP = array:new(N, {default, 0}),
    do_burst(Balloons, DP, 0, N-1).

do_burst(Balloons, DP, Left, Right) when Left > Right ->
    0;
do_burst(Balloons, DP, Left, Right) ->
    case array:get(Left, Right, DP) of
        Val when is_integer(Val) ->
            Val;
        _ ->
            Max = do_burst_helper(Balloons, DP, Left, Right, 0),
            array:set(Left, Right, Max, DP),
            Max
    end.

do_burst_helper(Balloons, DP, Left, Right, Max) when Left > Right ->
    Max;
do_burst_helper(Balloons, DP, Left, Right, Max) ->
    Current = lists:nth(Left + 1, Balloons),
    LeftVal = if Left == 0 -> 0; true -> lists:nth(Left, Balloons) end,
    RightVal = if Right == length(Balloons) - 1 -> 0; true -> lists:nth(Right + 2, Balloons) end,
    Cost = Current * LeftVal * RightVal,
    LeftRes = do_burst(Balloons, DP, Left, Left - 1),
    RightRes = do_burst(Balloons, DP, Left + 1, Right),
    Total = Cost + LeftRes + RightRes,
    do_burst_helper(Balloons, DP, Left, Right, max(Max, Total)).

array:new(Size, Default) ->
    array:new(Size, {default, Default}).

array:get(X, Y, Array) ->
    Index = X * size(Array) + Y,
    element(Index + 1, Array).

array:set(X, Y, Value, Array) ->
    Index = X * size(Array) + Y,
    setelement(Index + 1, Array, Value).

size(Array) ->
    erlang:element(1, Array).