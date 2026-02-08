-module(solution).
-export([sum_indices_with_k_set_bits/2]).

count_set_bits(0) -> 0;
count_set_bits(N) when N > 0 ->
    1 + count_set_bits(N band (N - 1)).

sum_indices_with_k_set_bits(Nums, K) ->
    sum_helper(Nums, K, 0, 0).

sum_helper([], _K, _CurrentIndex, AccSum) ->
    AccSum;
sum_helper([H|T], K, CurrentIndex, AccSum) ->
    case count_set_bits(CurrentIndex) of
        K ->
            sum_helper(T, K, CurrentIndex + 1, AccSum + H);
        _ ->
            sum_helper(T, K, CurrentIndex + 1, AccSum)
    end.