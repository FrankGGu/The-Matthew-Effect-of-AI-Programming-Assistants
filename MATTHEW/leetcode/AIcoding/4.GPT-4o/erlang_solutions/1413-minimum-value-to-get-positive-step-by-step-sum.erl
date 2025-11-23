-module(solution).
-export([min_start_value/1]).

min_start_value(List) ->
    Sum = lists:foldl(fun(X, Acc) -> Acc + X end, 0, List),
    Min = lists:foldl(fun(X, Acc) -> min(Acc, Acc + X) end, 0, List),
    max(1 - Min, 1).