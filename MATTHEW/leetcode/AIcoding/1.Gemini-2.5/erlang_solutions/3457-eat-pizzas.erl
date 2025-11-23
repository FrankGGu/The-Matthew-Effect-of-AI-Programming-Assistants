-module(solution).
-export([can_eat_pizzas/2]).

can_eat_pizzas(Pizzas, Target) when Target < 0 -> false;
can_eat_pizzas(Pizzas, Target) ->
    DP = array:new([{size, Target + 1}, {fixed, true}, {default, false}]),
    DP1 = array:set(0, true, DP),

    FinalDP = lists:foldl(
        fun(PizzaSize, CurrentDP) ->
            lists:foldl(
                fun(J, InnerDP) ->
                    IfCanFormJMinusPizzaSize = array:get(J - PizzaSize, InnerDP),
                    IfCanFormJ = array:get(J, InnerDP),
                    array:set(J, IfCanFormJ or IfCanFormJMinusPizzaSize, InnerDP)
                end,
                CurrentDP,
                lists:seq(Target, PizzaSize, -1)
            )
        end,
        DP1,
        Pizzas
    ),
    array:get(Target, FinalDP).