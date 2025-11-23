-spec maximum_units(BoxTypes :: [[integer()]], TruckSize :: integer()) -> integer().
maximum_units(BoxTypes, TruckSize) ->
    Sorted = lists:sort(fun([_, A], [_, B]) -> A >= B end, BoxTypes),
    calculate(Sorted, TruckSize, 0).

calculate(_, 0, Acc) -> Acc;
calculate([], _, Acc) -> Acc;
calculate([[BoxCount, UnitsPerBox] | Rest], TruckSize, Acc) ->
    Taken = min(BoxCount, TruckSize),
    calculate(Rest, TruckSize - Taken, Acc + Taken * UnitsPerBox).