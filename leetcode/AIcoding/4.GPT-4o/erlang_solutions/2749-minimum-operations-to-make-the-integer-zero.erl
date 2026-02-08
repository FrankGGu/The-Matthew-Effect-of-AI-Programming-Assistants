-module(solution).
-export([minimum_operations/1]).

minimum_operations(N) when N >= 0 ->
    minimum_operations(N, 0).

minimum_operations(0, Count) -> 
    Count;
minimum_operations(N, Count) ->
    NewN = N - (N band -N),
    minimum_operations(NewN, Count + 1).