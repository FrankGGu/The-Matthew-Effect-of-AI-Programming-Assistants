-module(solution).
-export([closest_dessert_cost/3]).

closest_dessert_cost(BaseCosts, ToppingCosts, Target) ->
    ToppingCombinations = lists:foldl(fun(Costs, Acc) ->
        [X + Y || X <- Acc, Y <- Costs] ++ Acc
    end, [0], ToppingCosts),
    Desserts = [Base + Topping || Base <- BaseCosts, Topping <- ToppingCombinations],
    lists:max(lists:filter(fun(X) -> X =< Target end, Desserts)).