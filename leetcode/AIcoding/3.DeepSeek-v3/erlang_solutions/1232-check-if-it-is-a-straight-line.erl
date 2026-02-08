-spec check_straight_line(Coordinates :: [[integer()]]) -> boolean().
check_straight_line(Coordinates) ->
    case Coordinates of
        [[X1, Y1], [X2, Y2] | Rest] ->
            DX = X2 - X1,
            DY = Y2 - Y1,
            lists:all(fun([X, Y]) -> DY * (X - X1) == DX * (Y - Y1) end, Rest);
        _ ->
            true
    end.