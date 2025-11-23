-module(solution).
-export([max_operations/1]).

max_operations(List) ->
    OnesCount = lists:foldl(fun(X, Acc) -> if X == 1 -> Acc + 1; true -> Acc end end, 0, List),
    Length = length(List),
    Length - OnesCount - lists:foldl(fun(X, Acc) -> if X == 0 -> Acc + 1; true -> Acc end end, 0, List).