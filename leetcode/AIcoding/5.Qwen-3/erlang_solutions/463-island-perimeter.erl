-module(island_perimeter).
-export([islandPerimeter/1]).

islandPerimeter(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Columns = length(hd(Grid)),
            calculate_perimeter(Grid, 0, 0, Rows, Columns, 0)
    end.

calculate_perimeter(_, _, C, _, Columns, Acc) when C >= Columns ->
    Acc;
calculate_perimeter(_, R, _, _, Columns, Acc) when R >= length(Grid) ->
    Acc;
calculate_perimeter(Grid, R, C, Rows, Columns, Acc) ->
    Cell = lists:nth(R+1, Grid),
    Value = lists:nth(C+1, Cell),
    case Value of
        1 ->
            Edges = count_edges(Grid, R, C, Rows, Columns),
            calculate_perimeter(Grid, R, C+1, Rows, Columns, Acc + Edges);
        _ ->
            calculate_perimeter(Grid, R, C+1, Rows, Columns, Acc)
    end.

count_edges(Grid, R, C, Rows, Columns) ->
    Edges = 0,
    check_up(Grid, R, C, Rows, Columns, Edges),
    check_down(Grid, R, C, Rows, Columns, Edges),
    check_left(Grid, R, C, Rows, Columns, Edges),
    check_right(Grid, R, C, Rows, Columns, Edges).

check_up(_, 0, _, _, _, Acc) ->
    Acc + 1;
check_up(Grid, R, C, Rows, Columns, Acc) ->
    PrevRow = R - 1,
    Cell = lists:nth(PrevRow+1, Grid),
    Value = lists:nth(C+1, Cell),
    if
        Value == 0 -> Acc + 1;
        true -> Acc
    end.

check_down(Grid, R, C, Rows, Columns, Acc) ->
    NextRow = R + 1,
    if
        NextRow >= Rows -> Acc + 1;
        true ->
            Cell = lists:nth(NextRow+1, Grid),
            Value = lists:nth(C+1, Cell),
            if
                Value == 0 -> Acc + 1;
                true -> Acc
            end
    end.

check_left(_, _, 0, _, _, Acc) ->
    Acc + 1;
check_left(Grid, R, C, Rows, Columns, Acc) ->
    PrevCol = C - 1,
    Cell = lists:nth(R+1, Grid),
    Value = lists:nth(PrevCol+1, Cell),
    if
        Value == 0 -> Acc + 1;
        true -> Acc
    end.

check_right(Grid, R, C, Rows, Columns, Acc) ->
    NextCol = C + 1,
    if
        NextCol >= Columns -> Acc + 1;
        true ->
            Cell = lists:nth(R+1, Grid),
            Value = lists:nth(NextCol+1, Cell),
            if
                Value == 0 -> Acc + 1;
                true -> Acc
            end
    end.