-spec max_points(Points :: [[integer()]]) -> integer().
max_points(Points) ->
    PointsWithSlopes = lists:map(fun([X1, Y1], [X2, Y2]) ->
        case {X2 - X1, Y2 - Y1} of
            {Dx, Dy} when Dx == 0 -> {infinity, Dy};
            {Dx, Dy} -> {Dy, Dx}
        end
    end, Points),
    lists:flatten(PointsWithSlopes).
