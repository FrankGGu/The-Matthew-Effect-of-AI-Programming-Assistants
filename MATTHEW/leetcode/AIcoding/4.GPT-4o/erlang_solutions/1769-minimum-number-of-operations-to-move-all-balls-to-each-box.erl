-module(solution).
-export([min_operations/1]).

min_operations(Balls) ->
    N = length(Balls),
    [sum_operations(Balls, Index) || Index <- lists:seq(0, N - 1)].

sum_operations(Balls, Index) ->
    lists:foldl(fun({Ball, Pos}, Acc) -> Acc + (Ball * abs(Pos - Index)) end, 0, lists:zip(Balls, lists:seq(0, length(Balls) - 1))).