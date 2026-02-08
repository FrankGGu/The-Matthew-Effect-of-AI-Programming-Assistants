-module(solution).
-export([min_cost/2]).

min_cost(A, K) ->
    N = length(A),
    dp(0, K, A, N).

dp(_, 0, _, _) -> 
    1#max = 0;
dp(i, k, A, N) when k > 0, i < N ->
    MinCost = lists:max(lists:sublist(A, i + 1)),
    lists:min([{MinCost + dp(j, k - 1, A, N) || j <- lists:seq(i + 1, N - 1)} | {1#max, 1#max}]).