-module(solution).
-export([min_cost/1]).

min_cost(Prices) ->
    N = length(Prices),
    DP = array:new(N, {default, 0}),
    array:set(0, 0, DP),
    lists:foreach(fun(I) -> update_dp(I, Prices, DP) end, lists:seq(1, N-1)),
    array:get(N-1, DP).

update_dp(I, Prices, DP) ->
    MinCost = lists:min([array:get(J, DP) + cost(J, I, Prices) || J <- lists:seq(0, I-1)]),
    array:set(I, MinCost, DP).

cost(A, B, Prices) ->
    MaxVal = lists:max(lists:sublist(Prices, A+1, B - A)),
    MaxVal * (B - A).