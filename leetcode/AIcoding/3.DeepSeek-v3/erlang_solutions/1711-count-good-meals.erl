-spec count_pairs(GoodMeals :: [integer()]) -> integer().
count_pairs(GoodMeals) ->
    Counts = maps:new(),
    Mod = 1000000007,
    lists:foldl(fun(Meal, {Acc, Counts0}) ->
        Power = 1,
        Sum = 0,
        NewSum = lists:foldl(fun(_, {Sum0, Power0}) ->
            NextPower = Power0 bsl 1,
            case maps:get(NextPower - Meal, Counts0, 0) of
                0 -> {Sum0, NextPower};
                Val -> {(Sum0 + Val) rem Mod, NextPower}
            end
        end, {Sum, Power}, lists:seq(1, 22)),
        {Sum1, _} = NewSum,
        NewCounts = maps:update_with(Meal, fun(V) -> V + 1 end, 1, Counts0),
        {(Acc + Sum1) rem Mod, NewCounts}
    end, {0, Counts}, GoodMeals).