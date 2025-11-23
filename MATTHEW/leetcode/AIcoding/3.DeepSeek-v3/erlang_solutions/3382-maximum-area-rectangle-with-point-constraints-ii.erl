-spec max_area_rect(Points :: [[integer()]]) -> integer().
max_area_rect(Points) ->
    PointsSet = sets:from_list([{X, Y} || [X, Y] <- Points]),
    N = length(Points),
    MaxArea = 0,
    find_max_area(Points, PointsSet, N, MaxArea).

find_max_area([], _, _, MaxArea) -> MaxArea;
find_max_area([ [X1, Y1] | Rest ], PointsSet, N, MaxArea) ->
    NewMax = lists:foldl(
        fun([X2, Y2], Acc) ->
            if
                X2 > X1 andalso Y2 > Y1 ->
                    case sets:is_element({X1, Y2}, PointsSet) andalso sets:is_element({X2, Y1}, PointsSet) of
                        true -> 
                            Area = (X2 - X1) * (Y2 - Y1),
                            max(Acc, Area);
                        false -> Acc
                    end;
                true -> Acc
            end
        end,
        MaxArea,
        Rest
    ),
    find_max_area(Rest, PointsSet, N, NewMax).