-module(cherry_pickup).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    N = length(Grid),
    Max = 2 * N - 2,
    DP = array:new([{size, Max + 1}, {default, -1}]),
    DP1 = array:set(0, array:new([{size, N}, {default, -1}]), DP),
    DP2 = array:set(0, array:set(0, hd(Grid), array:new([{size, N}, {default, -1}]))),
    cherry_pickup(Grid, 0, 0, 0, DP2).

cherry_pickup(_, _, N, _, _) when N == length(Grid) -> -1;
cherry_pickup(Grid, X1, Y1, Step, DP) ->
    X2 = Step - Y1,
    Y2 = Step - X1,
    if
        X1 < 0; X1 >= length(Grid); Y1 < 0; Y1 >= length(Grid); X2 < 0; X2 >= length(Grid); Y2 < 0; Y2 >= length(Grid) -> -1;
        true ->
            Current = array:get(Step, DP),
            Val = array:get(Y1, Current),
            if Val /= -1 -> Val;
               true ->
                    Pick = if
                               X1 == X2 andalso Y1 == Y2 -> grid(Grid, X1, Y1);
                               true -> grid(Grid, X1, Y1) + grid(Grid, X2, Y2)
                           end,
                    MaxVal = max(
                        cherry_pickup(Grid, X1 + 1, Y1, Step + 1, DP),
                        cherry_pickup(Grid, X1, Y1 + 1, Step + 1, DP)
                    ),
                    if MaxVal == -1 -> -1;
                       true ->
                            NewVal = Pick + MaxVal,
                            NewCurrent = array:set(Y1, NewVal, Current),
                            NewDP = array:set(Step, NewCurrent, DP),
                            NewVal
                    end
            end
    end.

grid(Grid, X, Y) ->
    lists:nth(X + 1, Grid),
    lists:nth(Y + 1, lists:nth(X + 1, Grid)).