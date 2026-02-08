-module(eat_pizzas).
-export([max_pizza/1]).

max_pizza(Pizza) ->
    max_pizza(Pizza, 0, 0).

max_pizza([], _, Max) ->
    Max;
max_pizza([H|T], Index, Max) ->
    Current = H,
    NewMax = if
        Current > Max -> Current;
        true -> Max
    end,
    max_pizza(T, Index + 1, NewMax).