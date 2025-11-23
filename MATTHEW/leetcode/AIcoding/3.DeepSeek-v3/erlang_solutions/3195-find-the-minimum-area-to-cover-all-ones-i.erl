-spec min_area(Grid :: [[char()]], X :: integer(), Y :: integer()) -> integer().
min_area(Grid, X, Y) ->
    {MinRow, MaxRow} = find_min_max_row(Grid, X, Y),
    {MinCol, MaxCol} = find_min_max_col(Grid, X, Y),
    (MaxRow - MinRow + 1) * (MaxCol - MinCol + 1).

find_min_max_row(Grid, X, Y) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MinRow = find_min_row(Grid, X, Y, Rows, Cols),
    MaxRow = find_max_row(Grid, X, Y, Rows, Cols),
    {MinRow, MaxRow}.

find_min_row(Grid, X, Y, Rows, Cols) ->
    find_min_row(Grid, X, Y, Rows, Cols, X).

find_min_row(Grid, X, Y, Rows, Cols, Min) ->
    case X >= 0 of
        true ->
            case has_one_in_row(Grid, X, Cols) of
                true -> find_min_row(Grid, X - 1, Y, Rows, Cols, X);
                false -> find_min_row(Grid, X - 1, Y, Rows, Cols, Min)
            end;
        false -> Min
    end.

find_max_row(Grid, X, Y, Rows, Cols) ->
    find_max_row(Grid, X, Y, Rows, Cols, X).

find_max_row(Grid, X, Y, Rows, Cols, Max) ->
    case X < Rows of
        true ->
            case has_one_in_row(Grid, X, Cols) of
                true -> find_max_row(Grid, X + 1, Y, Rows, Cols, X);
                false -> find_max_row(Grid, X + 1, Y, Rows, Cols, Max)
            end;
        false -> Max
    end.

find_min_max_col(Grid, X, Y) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MinCol = find_min_col(Grid, X, Y, Rows, Cols),
    MaxCol = find_max_col(Grid, X, Y, Rows, Cols),
    {MinCol, MaxCol}.

find_min_col(Grid, X, Y, Rows, Cols) ->
    find_min_col(Grid, X, Y, Rows, Cols, Y).

find_min_col(Grid, X, Y, Rows, Cols, Min) ->
    case Y >= 0 of
        true ->
            case has_one_in_col(Grid, Y, Rows) of
                true -> find_min_col(Grid, X, Y - 1, Rows, Cols, Y);
                false -> find_min_col(Grid, X, Y - 1, Rows, Cols, Min)
            end;
        false -> Min
    end.

find_max_col(Grid, X, Y, Rows, Cols) ->
    find_max_col(Grid, X, Y, Rows, Cols, Y).

find_max_col(Grid, X, Y, Rows, Cols, Max) ->
    case Y < Cols of
        true ->
            case has_one_in_col(Grid, Y, Rows) of
                true -> find_max_col(Grid, X, Y + 1, Rows, Cols, Y);
                false -> find_max_col(Grid, X, Y + 1, Rows, Cols, Max)
            end;
        false -> Max
    end.

has_one_in_row(Grid, Row, Cols) ->
    has_one_in_row(Grid, Row, Cols, 0).

has_one_in_row(Grid, Row, Cols, Col) ->
    case Col < Cols of
        true ->
            case lists:nth(Col + 1, lists:nth(Row + 1, Grid)) of
                $1 -> true;
                _ -> has_one_in_row(Grid, Row, Cols, Col + 1)
            end;
        false -> false
    end.

has_one_in_col(Grid, Col, Rows) ->
    has_one_in_col(Grid, Col, Rows, 0).

has_one_in_col(Grid, Col, Rows, Row) ->
    case Row < Rows of
        true ->
            case lists:nth(Col + 1, lists:nth(Row + 1, Grid)) of
                $1 -> true;
                _ -> has_one_in_col(Grid, Col, Rows, Row + 1)
            end;
        false -> false
    end.