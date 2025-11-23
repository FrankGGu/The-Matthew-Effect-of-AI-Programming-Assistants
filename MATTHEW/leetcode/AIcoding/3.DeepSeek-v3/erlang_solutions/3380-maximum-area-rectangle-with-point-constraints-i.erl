-spec max_area(Width :: integer(), Height :: integer(), Points :: [[integer()]]) -> integer().
max_area(Width, Height, Points) ->
    PointsSet = sets:from_list([{X, Y} || [X, Y] <- Points]),
    PointsList = lists:sort([{X, Y} || [X, Y] <- Points]),
    MaxArea = 0,
    find_max_area(PointsList, PointsSet, Width, Height, MaxArea).

find_max_area([], _, _, _, MaxArea) -> MaxArea;
find_max_area([{X1, Y1} | Rest], PointsSet, Width, Height, MaxArea) ->
    NewMaxArea = lists:foldl(
        fun({X2, Y2}, CurrentMax) ->
            case X2 > X1 andalso Y2 > Y1 andalso 
                 sets:is_element({X1, Y2}, PointsSet) andalso 
                 sets:is_element({X2, Y1}, PointsSet) of
                true -> 
                    Area = (X2 - X1) * (Y2 - Y1),
                    max(CurrentMax, Area);
                false -> CurrentMax
            end
        end,
        MaxArea,
        Rest
    ),
    find_max_area(Rest, PointsSet, Width, Height, NewMaxArea).