-module(min_cost_climbing_stairs).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Cost) ->
    min_cost_climbing_stairs(Cost, 0, 0).

min_cost_climbing_stairs([], A, B) ->
    min(A, B);
min_cost_climbing_stairs([C | T], A, B) ->
    NewA = B,
    NewB = C + min(A, B),
    min_cost_climbing_stairs(T, NewA, NewB).