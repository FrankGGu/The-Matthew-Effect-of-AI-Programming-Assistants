-module(solution).
-export([max_sum_with_k_elements/2]).

max_sum_with_k_elements(Nums, K) ->
    Max = lists:max(Nums),
    Score = Max * K + K * (K - 1) div 2,
    Score.