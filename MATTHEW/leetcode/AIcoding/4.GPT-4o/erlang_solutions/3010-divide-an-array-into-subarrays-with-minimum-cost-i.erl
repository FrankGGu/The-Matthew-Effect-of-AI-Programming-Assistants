-module(solution).
-export([min_cost/2]).

min_cost(N, A) ->
    min_cost_helper(N, A, 0, 1, 0).

min_cost_helper(N, A, Cost, K, Last) when K > N ->
    Cost;
min_cost_helper(N, A, Cost, K, Last) ->
    NewCost = Cost + (Last * A[K-1]),
    min_cost_helper(N, A, NewCost, K + 1, A[K-1]).