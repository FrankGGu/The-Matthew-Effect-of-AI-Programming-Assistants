-spec island_perimeter(Grid :: [[integer()]]) -> integer().
island_perimeter(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Perimeter = 0,
    island_perimeter(Grid, Rows, Cols, 0, 0, Perimeter).

island_perimeter(Grid, Rows, Cols, I, J, Perimeter) when I >= Rows ->
    Perimeter;
island_perimeter(Grid, Rows, Cols, I, J, Perimeter) when J >= Cols ->
    island_perimeter(Grid, Rows, Cols, I + 1, 0, Perimeter);
island_perimeter(Grid, Rows, Cols, I, J, Perimeter) ->
    case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
        1 ->
            NewPerimeter = Perimeter + 4,
            Adjacent = adjacent_cells(I, J, Rows, Cols),
            Subtract = count_adjacent_lands(Grid, Adjacent),
            island_perimeter(Grid, Rows, Cols, I, J + 1, NewPerimeter - Subtract);
        _ ->
            island_perimeter(Grid, Rows, Cols, I, J + 1, Perimeter)
    end.

adjacent_cells(I, J, Rows, Cols) ->
    Adjacent = [],
    Adjacent1 = if I > 0 -> [{I - 1, J} | Adjacent]; true -> Adjacent end,
    Adjacent2 = if I < Rows - 1 -> [{I + 1, J} | Adjacent1]; true -> Adjacent1 end,
    Adjacent3 = if J > 0 -> [{I, J - 1} | Adjacent2]; true -> Adjacent2 end,
    Adjacent4 = if J < Cols - 1 -> [{I, J + 1} | Adjacent3]; true -> Adjacent3 end,
    Adjacent4.

count_adjacent_lands(Grid, Adjacent) ->
    lists:foldl(fun({X, Y}, Acc) ->
        case lists:nth(Y + 1, lists:nth(X + 1, Grid)) of
            1 -> Acc + 1;
            _ -> Acc
        end
    end, 0, Adjacent).