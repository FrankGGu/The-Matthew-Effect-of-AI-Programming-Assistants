-module(solution).
-export([longest_v_shaped_diagonal/1]).

longest_v_shaped_diagonal(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Max1 = check_diagonals(Matrix, Rows, Cols, 0, 0, 0),
            Max2 = check_diagonals(Matrix, Rows, Cols, 0, Cols - 1, 0),
            max(Max1, Max2)
    end.

check_diagonals(_, Rows, Cols, Row, Col, Max) when Row >= Rows orelse Col >= Cols orelse Row < 0 orelse Col < 0 ->
    Max;
check_diagonals(Matrix, Rows, Cols, Row, Col, Max) ->
    Current = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
    case is_v_shaped(Matrix, Row, Col, Rows, Cols) of
        true ->
            NewMax = Max + 1,
            check_diagonals(Matrix, Rows, Cols, Row + 1, Col + 1, NewMax);
        false ->
            max(Max, check_diagonals(Matrix, Rows, Cols, Row + 1, Col + 1, 0))
    end.

is_v_shaped(Matrix, Row, Col, Rows, Cols) ->
    if
        Row + 1 >= Rows orelse Col + 1 >= Cols orelse Row - 1 < 0 orelse Col - 1 < 0 ->
            false;
        true ->
            Current = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
            Top = lists:nth(Col + 1, lists:nth(Row, Matrix)),
            Bottom = lists:nth(Col + 1, lists:nth(Row + 2, Matrix)),
            Left = lists:nth(Col, lists:nth(Row + 1, Matrix)),
            Right = lists:nth(Col + 2, lists:nth(Row + 1, Matrix)),
            (Current > Top andalso Current > Bottom) orelse (Current > Left andalso Current > Right)
    end.