-module(longest_v_shaped_diagonal).
-export([solve/1]).

solve(matrix) ->
    solve(matrix, 0).

solve(matrix, MaxLength) ->
    {Rows, Cols} = matrix_size(matrix),
    solve(matrix, 0, 0, Rows, Cols, MaxLength).

solve(_Matrix, Row, _Col, Rows, _Cols, MaxLength) when Row >= Rows ->
    MaxLength;
solve(Matrix, Row, Col, Rows, Cols, MaxLength) when Col >= Cols ->
    solve(Matrix, Row + 1, 0, Rows, Cols, MaxLength);
solve(Matrix, Row, Col, Rows, Cols, MaxLength) ->
    NewMaxLength = max(MaxLength, find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols)),
    solve(Matrix, Row, Col + 1, Rows, Cols, NewMaxLength).

find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols) ->
    find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols, 0).

find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols, MaxLength) ->
    find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols, 0, 1, 1, 0).

find_v_shaped_diagonal(Matrix, Row, Col, Rows, Cols, Length, DownRight, DownLeft, MaxLength) ->
    case {is_valid(Row, Col, Rows, Cols), lists:nth(Row + 1, lists:nth(Col + 1, Matrix))} of
        {false, _} ->
            MaxLength;
        {true, 0} ->
            MaxLength;
        {true, 1} ->
            NewRowRight = Row + DownRight,
            NewColRight = Col + DownRight,
            NewRowLeft = Row + DownLeft,
            NewColLeft = Col - DownLeft,
            case {is_valid(NewRowRight, NewColRight, Rows, Cols), is_valid(NewRowLeft, NewColLeft, Rows, Cols)} of
                {false, false} ->
                    max(MaxLength, Length + 1);
                {true, false} ->
                     find_v_shaped_diagonal(Matrix, NewRowRight, NewColRight, Rows, Cols, Length + 1, DownRight + 1, 1, MaxLength);
                {false, true} ->
                    find_v_shaped_diagonal(Matrix, NewRowLeft, NewColLeft, Rows, Cols, Length + 1, 1, DownLeft + 1, MaxLength);
                {true, true} ->
                    find_v_shaped_diagonal(Matrix, NewRowLeft, NewColLeft, Rows, Cols, find_v_shaped_diagonal(Matrix, NewRowRight, NewColRight, Rows, Cols, Length + 1, DownRight + 1, 1, MaxLength), 1, DownLeft + 1, MaxLength)
            end
    end.

is_valid(Row, Col, Rows, Cols) ->
    Row >= 0 and Row < Rows and Col >= 0 and Col < Cols.

matrix_size(Matrix) ->
    Rows = length(Matrix),
    Cols = length(lists:nth(1, Matrix)),
    {Rows, Cols}.