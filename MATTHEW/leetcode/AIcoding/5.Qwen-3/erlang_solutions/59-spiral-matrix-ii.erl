-module(spiral_matrix_ii).
-export([generate_matrix/1]).

generate_matrix(N) ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    generate_matrix(N, 0, 0, 1, Matrix).

generate_matrix(_, _, _, N, _) when N == 0 -> [];
generate_matrix(N, Row, Col, Val, Matrix) ->
    case Val > N * N of
        true -> Matrix;
        false ->
            {NewMatrix, NewRow, NewCol} = fill_row(N, Row, Col, Val, Matrix),
            {NewMatrix2, NewRow2, NewCol2} = fill_col(N, NewRow, NewCol, Val + (N - 1), NewMatrix),
            {NewMatrix3, NewRow3, NewCol3} = fill_row_back(N, NewRow2, NewCol2, Val + (N - 1) + (N - 1), NewMatrix2),
            {NewMatrix4, NewRow4, NewCol4} = fill_col_back(N, NewRow3, NewCol3, Val + (N - 1) + (N - 1) + (N - 1), NewMatrix3),
            generate_matrix(N, NewRow4, NewCol4, Val + (N - 1) * 3 + 1, NewMatrix4)
    end.

fill_row(N, Row, Col, Val, Matrix) ->
    if
        Col < N ->
            NewMatrix = set_element(Matrix, Row, Col, Val),
            fill_row(N, Row, Col + 1, Val + 1, NewMatrix);
        true -> {Matrix, Row, Col}
    end.

fill_col(N, Row, Col, Val, Matrix) ->
    if
        Row < N - 1 ->
            NewMatrix = set_element(Matrix, Row + 1, Col, Val),
            fill_col(N, Row + 1, Col, Val + 1, NewMatrix);
        true -> {Matrix, Row, Col}
    end.

fill_row_back(N, Row, Col, Val, Matrix) ->
    if
        Col > 0 ->
            NewMatrix = set_element(Matrix, Row, Col - 1, Val),
            fill_row_back(N, Row, Col - 1, Val + 1, NewMatrix);
        true -> {Matrix, Row, Col}
    end.

fill_col_back(N, Row, Col, Val, Matrix) ->
    if
        Row > 0 ->
            NewMatrix = set_element(Matrix, Row - 1, Col, Val),
            fill_col_back(N, Row - 1, Col, Val + 1, NewMatrix);
        true -> {Matrix, Row, Col}
    end.

set_element(Matrix, Row, Col, Val) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = lists:sublist(RowList, Col) ++ [Val] ++ lists:sublist(RowList, Col + 1, length(RowList) - Col),
    lists:substitute(Row + 1, NewRowList, Matrix).