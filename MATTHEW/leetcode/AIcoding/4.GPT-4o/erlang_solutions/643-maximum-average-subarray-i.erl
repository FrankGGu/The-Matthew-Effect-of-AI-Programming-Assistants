-module(solution).
-export([find_max_average/1]).

find_max_average(List) ->
    N = length(List),
    Sum = lists:sum(List),
    MaxSum = lists:foldl(fun(X, Acc) -> max(X, Acc) end, hd(List), List),
    MaxSum / N.