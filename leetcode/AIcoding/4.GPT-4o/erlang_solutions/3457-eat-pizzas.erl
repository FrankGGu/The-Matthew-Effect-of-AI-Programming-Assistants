-module(solution).
-export([max_eaten_pizzas/2]).

max_eaten_pizzas(P, T) ->
    max_eaten_pizzas_helper(P, T, 0, 0).

max_eaten_pizzas_helper([], _, Max, _) -> Max;
max_eaten_pizzas_helper([H | T], Time, Max, Eaten) when Time > 0 ->
    max_eaten_pizzas_helper(T, Time - 1, max(Max, Eaten + H), Eaten + H);
max_eaten_pizzas_helper([H | T], Time, Max, Eaten) ->
    max_eaten_pizzas_helper(T, Time, Max, Eaten).