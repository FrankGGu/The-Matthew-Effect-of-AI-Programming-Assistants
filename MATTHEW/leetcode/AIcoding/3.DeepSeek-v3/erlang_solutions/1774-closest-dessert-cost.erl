-spec closest_cost(BaseCosts :: [integer()], ToppingCosts :: [integer()], Target :: integer()) -> integer().
closest_cost(BaseCosts, ToppingCosts, Target) ->
    MinBase = lists:min(BaseCosts),
    if
        MinBase >= Target -> MinBase;
        true ->
            MaxToppings = (Target - MinBase) div lists:min(ToppingCosts) + 2,
            ToppingsCombinations = generate_combinations(ToppingCosts, MaxToppings),
            lists:foldl(
                fun(Base, Acc) ->
                    lists:foldl(
                        fun(ToppingsCost, CurrentBest) ->
                            Total = Base + ToppingsCost,
                            update_best(Total, Target, CurrentBest)
                        end,
                        Acc,
                        ToppingsCombinations
                    )
                end,
                hd(BaseCosts),
                BaseCosts
            )
    end.

generate_combinations(ToppingCosts, MaxToppings) ->
    Combinations = sets:new(),
    generate_combinations(ToppingCosts, MaxToppings, 0, 0, Combinations),
    sets:to_list(Combinations).

generate_combinations([], _, _, CurrentSum, Combinations) ->
    sets:add_element(CurrentSum, Combinations);
generate_combinations([Cost | Rest], MaxToppings, Count, CurrentSum, Combinations) ->
    NewCombinations = lists:foldl(
        fun(N, Acc) ->
            if
                Count + N > MaxToppings -> Acc;
                true ->
                    NewSum = CurrentSum + N * Cost,
                    NewAcc = generate_combinations(Rest, MaxToppings, Count + N, NewSum, Acc),
                    NewAcc
            end
        end,
        Combinations,
        lists:seq(0, 2)
    ),
    NewCombinations.

update_best(Total, Target, CurrentBest) ->
    DiffTotal = abs(Total - Target),
    DiffBest = abs(CurrentBest - Target),
    if
        DiffTotal < DiffBest -> Total;
        DiffTotal == DiffBest -> min(Total, CurrentBest);
        true -> CurrentBest
    end.