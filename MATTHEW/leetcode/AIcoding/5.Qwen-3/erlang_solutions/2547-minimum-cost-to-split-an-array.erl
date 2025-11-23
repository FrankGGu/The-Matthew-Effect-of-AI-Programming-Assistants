-module(minimum_cost_to_split_an_array).
-export([splitArray/2]).

splitArray(Prices, K) ->
    N = length(Prices),
    DP = array:new(N, {default, 0}),
    Max = array:new(N, {default, 0}),
    Max1 = array:new(N, {default, 0}),
    Max2 = array:new(N, {default, 0}),
    splitArray(Prices, K, N, DP, Max, Max1, Max2).

splitArray(_, 1, _, DP, _, _, _) ->
    array:get(0, DP);
splitArray(Prices, K, N, DP, Max, Max1, Max2) ->
    I = N - 1,
    J = N - 1,
    Current = array:get(I, DP),
    splitArray(Prices, K - 1, N - 1, DP, Max, Max1, Max2).

splitArray(_, _, _, _, _, _, _, _) ->
    ok.