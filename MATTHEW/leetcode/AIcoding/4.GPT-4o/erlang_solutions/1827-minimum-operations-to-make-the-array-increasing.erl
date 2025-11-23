-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    MinOps = min_operations_helper(Array, hd(Array), 0),
    MinOps.

min_operations_helper([], _, Count) -> 
    Count;
min_operations_helper([H|T], Prev, Count) when H > Prev -> 
    min_operations_helper(T, H, Count);
min_operations_helper([H|T], Prev, Count) -> 
    NewCount = Count + (Prev - H + 1),
    min_operations_helper(T, Prev + 1, NewCount).