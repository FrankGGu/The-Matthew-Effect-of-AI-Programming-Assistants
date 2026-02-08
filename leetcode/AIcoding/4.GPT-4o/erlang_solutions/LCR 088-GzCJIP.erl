-module(solution).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Cost) ->
    min_cost(Cost, length(Cost)).

min_cost(Cost, N) when N < 2 -> 
    0;
min_cost(Cost, N) -> 
    dp(Cost, N, []).

dp(_, 0, Acc) -> 
    lists:min(Acc);
dp(Cost, N, Acc) -> 
    dp(Cost, N - 1, [lists:nth(N, Cost) + lists:nth(N - 1, Acc) | Acc]),
    dp(Cost, N - 2, [lists:nth(N, Cost) + lists:nth(N - 2, Acc) | Acc]).