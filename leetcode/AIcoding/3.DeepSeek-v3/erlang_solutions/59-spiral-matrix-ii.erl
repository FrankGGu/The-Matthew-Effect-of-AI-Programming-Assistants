-spec generate_matrix(N :: integer()) -> [[integer()]].
generate_matrix(N) ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    generate_matrix(Matrix, 0, N - 1, 0, N - 1, 1).

generate_matrix(Matrix, _, _, _, _, Num) when Num > length(Matrix) * length(Matrix) ->
    Matrix;
generate_matrix(Matrix, RowStart, RowEnd, ColStart, ColEnd, Num) ->
    {NewMatrix, NewNum} = fill_top(Matrix, RowStart, ColStart, ColEnd, Num),
    {NewMatrix1, NewNum1} = fill_right(NewMatrix, ColEnd, RowStart + 1, RowEnd, NewNum),
    {NewMatrix2, NewNum2} = case RowStart =/= RowEnd of
        true -> fill_bottom(NewMatrix1, RowEnd, ColEnd - 1, ColStart, NewNum1);
        false -> {NewMatrix1, NewNum1}
    end,
    {NewMatrix3, NewNum3} = case ColStart =/= ColEnd of
        true -> fill_left(NewMatrix2, ColStart, RowEnd - 1, RowStart + 1, NewNum2);
        false -> {NewMatrix2, NewNum2}
    end,
    generate_matrix(NewMatrix3, RowStart + 1, RowEnd - 1, ColStart + 1, ColEnd - 1, NewNum3).

fill_top(Matrix, Row, ColStart, ColEnd, Num) ->
    fill_row(Matrix, Row, ColStart, ColEnd, 1, Num).

fill_right(Matrix, Col, RowStart, RowEnd, Num) ->
    fill_col(Matrix, Col, RowStart, RowEnd, 1, Num).

fill_bottom(Matrix, Row, ColStart, ColEnd, Num) ->
    fill_row(Matrix, Row, ColStart, ColEnd, -1, Num).

fill_left(Matrix, Col, RowStart, RowEnd, Num) ->
    fill_col(Matrix, Col, RowStart, RowEnd, -1, Num).

fill_row(Matrix, Row, ColStart, ColEnd, Dir, Num) ->
    case Dir of
        1 -> fill_row_forward(Matrix, Row, ColStart, ColEnd, Num);
        -1 -> fill_row_backward(Matrix, Row, ColStart, ColEnd, Num)
    end.

fill_row_forward(Matrix, Row, Col, ColEnd, Num) when Col > ColEnd ->
    {Matrix, Num};
fill_row_forward(Matrix, Row, Col, ColEnd, Num) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = set_element(RowList, Col + 1, Num),
    NewMatrix = set_element(Matrix, Row + 1, NewRowList),
    fill_row_forward(NewMatrix, Row, Col + 1, ColEnd, Num + 1).

fill_row_backward(Matrix, Row, Col, ColEnd, Num) when Col < ColEnd ->
    {Matrix, Num};
fill_row_backward(Matrix, Row, Col, ColEnd, Num) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = set_element(RowList, Col + 1, Num),
    NewMatrix = set_element(Matrix, Row + 1, NewRowList),
    fill_row_backward(NewMatrix, Row, Col - 1, ColEnd, Num + 1).

fill_col(Matrix, Col, RowStart, RowEnd, Dir, Num) ->
    case Dir of
        1 -> fill_col_forward(Matrix, Col, RowStart, RowEnd, Num);
        -1 -> fill_col_backward(Matrix, Col, RowStart, RowEnd, Num)
    end.

fill_col_forward(Matrix, Col, Row, RowEnd, Num) when Row > RowEnd ->
    {Matrix, Num};
fill_col_forward(Matrix, Col, Row, RowEnd, Num) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = set_element(RowList, Col + 1, Num),
    NewMatrix = set_element(Matrix, Row + 1, NewRowList),
    fill_col_forward(NewMatrix, Col, Row + 1, RowEnd, Num + 1).

fill_col_backward(Matrix, Col, Row, RowEnd, Num) when Row < RowEnd ->
    {Matrix, Num};
fill_col_backward(Matrix, Col, Row, RowEnd, Num) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = set_element(RowList, Col + 1, Num),
    NewMatrix = set_element(Matrix, Row + 1, NewRowList),
    fill_col_backward(NewMatrix, Col, Row - 1, RowEnd, Num + 1).

set_element(List, Index, Value) ->
    {Left, [_ | Right]} = lists:split(Index - 1, List),
    Left ++ [Value | Right].