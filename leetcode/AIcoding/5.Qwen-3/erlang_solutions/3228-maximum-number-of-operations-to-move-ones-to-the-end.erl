-module(solution).
-export([max_operations/1]).

max_operations(Nums) ->
    max_operations(Nums, 0, 0).

max_operations([], _, Acc) ->
    Acc;
max_operations([0 | T], Count, Acc) ->
    max_operations(T, Count + 1, Acc);
max_operations([1 | T], Count, Acc) ->
    max_operations(T, 0, Acc + 1).