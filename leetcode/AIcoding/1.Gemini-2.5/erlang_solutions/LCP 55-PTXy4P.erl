-module(solution).
-export([total_fruit/1]).

total_fruit(Fruits) ->
    Array = array:from_list(Fruits),
    Len = array:size(Array),
    total_fruit_impl(Array, Len, 0, 0, 0, #{}).

total_fruit_impl(Array, Len, Left, Right, MaxFruits, FruitCounts) when Right < Len ->
    FruitR = array:get(Right, Array),
    NewFruitCounts1 = maps:update_with(FruitR, fun(Count) -> Count + 1 end, 1, FruitCounts),

    {NewLeft, NewFruitCounts2} = balance_window(Array, Left, NewFruitCounts1),

    CurrentWindowSize = Right - NewLeft + 1,
    NewMaxFruits = max(MaxFruits, CurrentWindowSize),

    total_fruit_impl(Array, Len, NewLeft, Right + 1, NewMaxFruits, NewFruitCounts2);
total_fruit_impl(_Array, _Len, _Left, _Right, MaxFruits, _FruitCounts) ->
    MaxFruits.

balance_window(Array, Left, FruitCounts) ->
    case maps:size(FruitCounts) > 2 of
        true ->
            FruitL = array:get(Left, Array),
            CountL = maps:get(FruitL, FruitCounts),
            NewFruitCounts = 
                case CountL - 1 of
                    0 -> maps:remove(FruitL, FruitCounts);
                    NewCount -> maps:put(FruitL, NewCount, FruitCounts)
                end,
            balance_window(Array, Left + 1, NewFruitCounts);
        false ->
            {Left, FruitCounts}
    end.