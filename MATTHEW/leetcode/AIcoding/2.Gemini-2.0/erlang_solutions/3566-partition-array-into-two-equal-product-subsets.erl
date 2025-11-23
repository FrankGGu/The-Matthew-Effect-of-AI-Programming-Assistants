-module(partition_array_equal_product_subsets).
-export([can_partition/1]).

can_partition(Nums) ->
    can_partition(Nums, 1, 1, 0).

can_partition([], Prod1, Prod2, Len) ->
    Len > 0 andalso Prod1 =:= Prod2;
can_partition([H|T], Prod1, Prod2, Len) ->
    can_partition(T, Prod1 * H, Prod2, Len + 1) orelse
    can_partition(T, Prod1, Prod2 * H, Len + 1) orelse
    can_partition(T, Prod1, Prod2, Len).