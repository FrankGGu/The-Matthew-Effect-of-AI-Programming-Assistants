-spec min_area_rect(Points :: [[integer()]]) -> integer().
min_area_rect(Points) ->
    PointSet = sets:from_list([{X, Y} || [X, Y] <- Points]),
    MinArea = find_min_area(Points, PointSet, infinity),
    case MinArea of
        infinity -> 0;
        _ -> MinArea
    end.

find_min_area([], _, MinArea) -> MinArea;
find_min_area([P1 | Rest], PointSet, MinArea) ->
    [X1, Y1] = P1,
    NewMinArea = lists:foldl(
        fun(P2, Acc) ->
            [X2, Y2] = P2,
            case {X1 =/= X2, Y1 =/= Y2} of
                {true, true} ->
                    case {sets:is_element({X1, Y2}, PointSet), sets:is_element({X2, Y1}, PointSet)} of
                        {true, true} ->
                            Area = abs((X2 - X1) * (Y2 - Y1)),
                            min(Area, Acc);
                        _ ->
                            Acc
                    end;
                _ ->
                    Acc
            end
        end,
        MinArea,
        Rest
    ),
    find_min_area(Rest, PointSet, NewMinArea).