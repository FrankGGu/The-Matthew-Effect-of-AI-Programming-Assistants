-module(solution).
-export([k_items_with_maximum_sum/3]).

k_items_with_maximum_sum(K, M, S) ->
    MaxSum = min(K + M, S),
    MaxSum - max(0, MaxSum - K).