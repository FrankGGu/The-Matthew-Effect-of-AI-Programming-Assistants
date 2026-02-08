-module(find_x_value_ii).
-export([find_x_value/1]).

find_x_value(Nums) ->
    find_x_value(Nums, 0).

find_x_value([], Acc) ->
    Acc;
find_x_value([H|T], Acc) ->
    find_x_value(T, bitxor(Acc, H)).