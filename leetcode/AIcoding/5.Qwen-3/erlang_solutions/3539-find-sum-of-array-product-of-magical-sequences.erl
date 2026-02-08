-module(solution).
-export([magical_sequence_sum/1]).

magical_sequence_sum(Nums) ->
    magical_sequence_sum(Nums, 1, 0).

magical_sequence_sum([], _, Sum) ->
    Sum;
magical_sequence_sum([H | T], Index, Sum) ->
    Product = product_of_subarrays(H, T, Index),
    magical_sequence_sum(T, Index + 1, Sum + Product).

product_of_subarrays(_, [], _) ->
    1;
product_of_subarrays(Value, [H | T], Index) ->
    Value * H * product_of_subarrays(Value, T, Index + 1).