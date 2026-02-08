-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    FruitArray = array:from_list(Fruits),
    Len = array:size(FruitArray),

    total_fruit_impl(FruitArray, Len, 0, 0, maps:new(), 0).

total_fruit_impl(_FruitArray, Len, _Left, Right, _FruitCounts, MaxFruits) when Right >= Len ->
    MaxFruits;
total_fruit_impl(FruitArray, Len, Left, Right, FruitCounts, MaxFruits) ->
    Fruit_R = array:get(Right, FruitArray),
    NewFruitCounts1 = maps:update_with(Fruit_R, fun(Count) -> Count + 1 end, 1, FruitCounts),

    {NewLeft, NewFruitCounts2} = ensure_two_types(FruitArray, Left, NewFruitCounts1),

    CurrentWindowSize = Right - NewLeft + 1,
    NewMaxFruits = max(MaxFruits, CurrentWindowSize),

    total_fruit_impl(FruitArray, Len, NewLeft, Right + 1, NewFruitCounts2, NewMaxFruits).

ensure_two_types(FruitArray, CurrentLeft, FruitCounts) ->
    case maps:size(FruitCounts) > 2 of
        true ->
            Fruit_L = array:get(CurrentLeft, FruitArray),
            Count_L = maps:get(Fruit_L, FruitCounts),

            UpdatedFruitCounts = 
                case Count_L - 1 of
                    0 -> maps:remove(Fruit_L, FruitCounts);
                    NewCount -> maps:put(Fruit_L, NewCount, FruitCounts)
                end,

            ensure_two_types(FruitArray, CurrentLeft + 1, UpdatedFruitCounts);
        false ->
            {CurrentLeft, FruitCounts}
    end.