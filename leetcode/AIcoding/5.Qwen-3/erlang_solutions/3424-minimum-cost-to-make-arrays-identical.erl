-module(minimum_cost_to_make_arrays_identical).
-export([min_cost/2]).

min_cost(A, B) ->
    min_cost(A, B, 0, 0).

min_cost([], [], Acc, _) ->
    Acc;
min_cost([A | Arest], [B | Brest], Acc, I) ->
    Diff = abs(A - B),
    Cost = Diff * I,
    min_cost(Arest, Brest, Acc + Cost, I + 1).