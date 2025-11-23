-module(solution).
-export([min_operations/1]).

min_operations(N) ->
    Sum = (N * (N + 1)) div 2,
    (N * N) - Sum.