-module(minimum_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    min_operations(Nums, 0).

min_operations([], Acc) ->
    Acc;
min_operations([0|Rest], Acc) ->
    min_operations(Rest, Acc + 1);
min_operations([1|Rest], Acc) ->
    min_operations(Rest, Acc).