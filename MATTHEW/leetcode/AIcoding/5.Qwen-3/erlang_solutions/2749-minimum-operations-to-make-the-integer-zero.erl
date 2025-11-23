-module(min_operations).
-export([minimum_operations/1]).

minimum_operations(N) ->
    minimum_operations(N, 0).

minimum_operations(0, Acc) ->
    Acc;
minimum_operations(N, Acc) ->
    minimum_operations(N - 1, Acc + 1).