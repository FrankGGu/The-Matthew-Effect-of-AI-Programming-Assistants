-spec min_area_rect(Points :: [[integer()]]) -> integer().
min_area_rect(Points) ->
    PointSet = sets:from_list([{X, Y} || [X, Y] <- Points]),
    MinArea = find_min_area(Points, PointSet, infinity),
    case MinArea of
        infinity -> 0;
        _ -> MinArea
    end.

find_min_area([], _, MinArea) -> MinArea;
find_min_area([[X1, Y1] | Rest], PointSet, MinArea) ->
    NewMinArea = lists:foldl(
        fun([X2, Y2], Acc) ->
            if
                X2 =/= X1 andalso Y2 =/= Y1 ->
                    case sets:is_element({X1, Y2}, PointSet) andalso sets:is_element({X2, Y1}, PointSet) of
                        true ->
                            Area = abs((X2 - X1) * (Y2 - Y1)),
                            min(Acc, Area);
                        false ->
                            Acc
                    end;
                true ->
                    Acc
            end
        end,
        MinArea,
        Rest
    ),
    find_min_area(Rest, PointSet, NewMinArea).