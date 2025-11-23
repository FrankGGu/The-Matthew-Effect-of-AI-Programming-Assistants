-module(solution).
-export([max_sum_with_exactly_k_elements/2]).

max_sum_with_exactly_k_elements(Nums, K) ->
    MaxVal = lists:max(Nums),
    K * (2 * MaxVal + K - 1) div 2.