-module(solution).
-export([max_units/2]).

max_units(BoxTypes, TruckSize) ->
    SortedBoxTypes = lists:sort(fun([_N1, U1], [_N2, U2]) -> U1 >= U2 end, BoxTypes),
    calculate_max_units(SortedBoxTypes, TruckSize, 0).

calculate_max_units([], _TruckSize, TotalUnits) ->
    TotalUnits;
calculate_max_units([_ | _], 0, TotalUnits) ->
    TotalUnits;
calculate_max_units([[NumBoxes, UnitsPerBox] | Rest], TruckSize, CurrentTotalUnits) ->
    BoxesToLoad = min(NumBoxes, TruckSize),
    NewTotalUnits = CurrentTotalUnits + (BoxesToLoad * UnitsPerBox),
    RemainingTruckSize = TruckSize - BoxesToLoad,
    calculate_max_units(Rest, RemainingTruckSize, NewTotalUnits).