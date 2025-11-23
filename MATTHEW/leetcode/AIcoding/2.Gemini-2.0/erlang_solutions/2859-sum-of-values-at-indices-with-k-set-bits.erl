-module(sum_of_values).
-export([sum_indices_with_k_set_bits/2]).

sum_indices_with_k_set_bits(Nums, K) ->
    sum_indices_with_k_set_bits(Nums, K, 0, 0).

sum_indices_with_k_set_bits([], _, _, Acc) ->
    Acc;
sum_indices_with_k_set_bits([Num | Rest], K, Index, Acc) ->
    case count_set_bits(Index) of
        K ->
            sum_indices_with_k_set_bits(Rest, K, Index + 1, Acc + Num);
        _ ->
            sum_indices_with_k_set_bits(Rest, K, Index + 1, Acc)
    end.

count_set_bits(0) -> 0;
count_set_bits(N) ->
    count_set_bits(N band (N - 1)) + 1.