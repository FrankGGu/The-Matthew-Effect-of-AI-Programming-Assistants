-module(solution).
-export([maximum_units/2]).

maximum_units(BoxTypes, TruckSize) ->
    SortedBoxTypes = lists:sort(fun([_N1, U1], [_N2, U2]) -> U1 >= U2 end, BoxTypes),
    solve(SortedBoxTypes, TruckSize, 0).

solve([], _TruckSize, TotalUnits) ->
    TotalUnits;
solve(_BoxTypes, 0, TotalUnits) ->
    TotalUnits;
solve([[NumBoxes, UnitsPerBox] | Rest], TruckSize, TotalUnits) ->
    CanLoad = min(NumBoxes, TruckSize),
    NewTotalUnits = TotalUnits + CanLoad * UnitsPerBox,
    NewTruckSize = TruckSize - CanLoad,
    solve(Rest, NewTruckSize, NewTotalUnits).