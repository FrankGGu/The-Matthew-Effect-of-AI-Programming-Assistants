-module(maximum_area_rectangle).
-export([max_area/2]).

max_area(Points, Constraints) ->
    PointsList = lists:map(fun({X, Y}) -> {X, Y} end, Points),
    ConstraintsList = lists:map(fun({X1, Y1, X2, Y2}) -> {X1, Y1, X2, Y2} end, Constraints),
    calculate_max_area(PointsList, ConstraintsList).

calculate_max_area(Points, Constraints) ->
    MaxArea = lists:max(lists:map(fun(P) -> calculate_area(P, Constraints) end, Points)),
    MaxArea.

calculate_area(P, Constraints) ->
    lists:foldl(fun({X1, Y1, X2, Y2}, Acc) -> 
        Area = (X2 - X1) * (Y2 - Y1),
        if
            Area > Acc -> Area;
            true -> Acc
        end
    end, 0, Constraints).