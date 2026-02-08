-module(solution).
-export([min_area_rect/1]).

min_area_rect(Points) ->
    PointTuples = [list_to_tuple(P) || P <- Points],
    PointSet = sets:from_list(PointTuples),
    PointsList = sets:to_list(PointSet),

    MinArea = find_min_area_recursive(PointsList, PointSet, float('infinity')),

    case MinArea of
        float('infinity') -> 0;
        _ -> MinArea
    end.

find_min_area_recursive([], _PointSet, CurrentMinArea) ->
    CurrentMinArea;
find_min_area_recursive([P1={X1, Y1}|Rest], PointSet, CurrentMinArea) ->
    AreaAfterP1 = lists:foldl(
        fun(P2={X2, Y2}, AccMinArea) ->
            if
                X1 =/= X2 andalso Y1 =/= Y2 ->
                    P3 = {X1, Y2},
                    P4 = {X2, Y1},
                    if
                        sets:is_element(P3, PointSet) andalso sets:is_element(P4, PointSet) ->
                            Area = abs(X1 - X2) * abs(Y1 - Y2),
                            min(Area, AccMinArea);
                        true -> AccMinArea
                    end;
                true -> AccMinArea
            end
        end,
        CurrentMinArea,
        Rest
    ),
    find_min_area_recursive(Rest, PointSet, AreaAfterP1).