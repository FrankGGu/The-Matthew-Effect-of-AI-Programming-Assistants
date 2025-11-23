-module(solution).
-export([closest_dessert_cost/3]).

closest_dessert_cost(BaseCosts, ToppingCosts, Target) ->
    AllToppingSums = generate_topping_sums(ToppingCosts),

    InitialBestCost = hd(BaseCosts) + hd(AllToppingSums),

    lists:foldl(fun(BaseCost, CurrentBestCost) ->
        lists:foldl(fun(ToppingSum, AccBestCost) ->
            Cost = BaseCost + ToppingSum,
            Diff = abs(Cost - Target),
            BestDiff = abs(AccBestCost - Target),
            if
                Diff < BestDiff -> Cost;
                Diff == BestDiff -> min(Cost, AccBestCost);
                true -> AccBestCost
            end
        end, CurrentBestCost, AllToppingSums)
    end, InitialBestCost, BaseCosts).

generate_topping_sums(Toppings) ->
    lists:foldl(fun(Topping, CurrentSums) ->
        NewSums = lists:flatmap(fun(S) -> [S, S + Topping, S + 2*Topping] end, CurrentSums),
        lists:usort(NewSums)
    end, [0], Toppings).