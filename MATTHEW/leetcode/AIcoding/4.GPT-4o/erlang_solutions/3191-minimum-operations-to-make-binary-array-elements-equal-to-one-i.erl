-module(solution).
-export([min_operations/1]).

min_operations(BinaryArray) ->
    Count0 = lists:foldl(fun(X, Acc) -> Acc + (if X == 0 -> 1; true -> 0 end) end, 0, BinaryArray),
    Count1 = lists:foldl(fun(X, Acc) -> Acc + (if X == 1 -> 1; true -> 0 end) end, 0, BinaryArray),
    min(Count0, Count1).

min(A, B) -> if A < B -> A; true -> B end.