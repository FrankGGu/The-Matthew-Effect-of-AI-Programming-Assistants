-module(solution).
-export([reduction_operations/1]).

reduction_operations(Array) ->
    Max = lists:max(Array),
    Sorted = lists:sort(Array),
    Count = lists:foldl(fun(X, Acc) -> if X == Max -> Acc; true -> Acc + 1 end end, 0, Sorted),
    Length = length(Array),
    Length - Count.