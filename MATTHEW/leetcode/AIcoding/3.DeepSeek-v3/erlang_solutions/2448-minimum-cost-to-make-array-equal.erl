-spec min_cost(Nums :: [integer()], Cost :: [integer()]) -> integer().
min_cost(Nums, Cost) ->
    Pairs = lists:zip(Nums, Cost),
    Sorted = lists:keysort(1, Pairs),
    TotalCost = lists:sum(Cost),
    {Median, _} = find_median(Sorted, 0, TotalCost div 2),
    calculate_cost(Sorted, Median).

find_median([{Num, C} | Rest], Acc, Target) ->
    NewAcc = Acc + C,
    case NewAcc >= Target of
        true -> {Num, NewAcc};
        false -> find_median(Rest, NewAcc, Target)
    end.

calculate_cost([], _) -> 0;
calculate_cost([{Num, C} | Rest], Target) ->
    abs(Num - Target) * C + calculate_cost(Rest, Target).