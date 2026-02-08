-module(solution).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Stairs) ->
    min_cost(Stairs, length(Stairs), 0).

min_cost(_, 0, Cost) -> 
    Cost;
min_cost(Stairs, N, Cost) when N < 0 -> 
    Cost;
min_cost(Stairs, N, Cost) ->
    Step1 = lists:nth(N, Stairs) + min_cost(Stairs, N - 1, Cost),
    Step2 = lists:nth(N - 1, Stairs) + min_cost(Stairs, N - 2, Cost),
    min(Step1, Step2).

min(A, B) -> 
    if 
        A < B -> A;
        true -> B 
    end.