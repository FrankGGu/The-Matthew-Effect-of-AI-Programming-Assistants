-module(solution).
-export([maximum_units/2]).

maximum_units(box_types, truck_size) ->
    SortedBoxes = lists:sort(fun({Units1, _}, {Units2, _}) -> Units1 > Units2 end, box_types),
    maximum_units_helper(SortedBoxes, truck_size, 0).

maximum_units_helper([], _, TotalUnits) -> TotalUnits;
maximum_units_helper([{Units, NumBoxes} | Rest], TruckSize, TotalUnits) ->
    case TruckSize >= NumBoxes of
        true -> maximum_units_helper(Rest, TruckSize - NumBoxes, TotalUnits + Units * NumBoxes);
        false -> TotalUnits + Units * TruckSize
    end.