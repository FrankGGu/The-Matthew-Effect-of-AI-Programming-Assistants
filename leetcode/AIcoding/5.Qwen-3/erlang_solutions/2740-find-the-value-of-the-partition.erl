-module(solution).
-export([find_value_of_partition/1]).

find_value_of_partition(Nums) ->
    Sorted = lists:sort(Nums),
    find_value_of_partition(Sorted, 0).

find_value_of_partition([_], Acc) ->
    Acc;
find_value_of_partition([A, B | T], Acc) ->
    find_value_of_partition([B | T], Acc + (B - A)).