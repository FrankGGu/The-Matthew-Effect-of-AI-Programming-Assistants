-module(maximum_sum_with_exactly_k_elements).
-export([maximum_sum_with_exactly_k_elements/2]).

maximum_sum_with_exactly_k_elements(Nums, K) ->
    Max = lists:max(Nums),
    Max * K + K * (K - 1) div 2.