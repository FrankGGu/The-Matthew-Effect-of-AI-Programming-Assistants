-module(solve).
-export([min_cost/1]).

min_cost(Costs) ->
    min_cost(Costs, 0, 0, 0).

min_cost([], R, G, B) ->
    min(R, min(G, B));
min_cost([[R, G, B] | Rest], PR, PG, PB) ->
    NewR = R + min(PG, PB),
    NewG = G + min(PR, PB),
    NewB = B + min(PR, PG),
    min_cost(Rest, NewR, NewG, NewB).

min(A, B) when A < B -> A;
min(A, B) -> B.