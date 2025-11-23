-module(solution).
-export([min_cost/2]).

min_cost(N, K) ->
    min_cost(N, K, 0).

min_cost(0, _, Cost) -> Cost;
min_cost(N, K, Cost) when N > 0 ->
    min_cost(N - 1, K, Cost + K).