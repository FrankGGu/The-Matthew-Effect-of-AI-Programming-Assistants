-module(spiral_matrix_ii).
-export([generate_matrix/1]).

generate_matrix(N) ->
    case N of
        0 -> [];
        _ ->
            Matrix = array:new({N, N}, 0),
            FinalMatrix = spiral_fill(Matrix, N, 1, 0, N - 1, 0, N - 1),
            array_to_list_of_lists(FinalMatrix, N, 0, [])
    end.

spiral_fill(Matrix, N, Val, Top, Bottom, Left, Right) ->
    if
        Top > Bottom; Left > Right ->
            Matrix;
        Val > N*N ->
            Matrix;
        true ->
            {Matrix1, Val1} = fill_right(Matrix, Top, Left, Right, Val),

            {Matrix2, Val2} = fill_down(Matrix1, Right, Top + 1, Bottom, Val1),

            {Matrix3, Val3} = 
                if Top + 1 <= Bottom ->
                    fill_left(Matrix2, Bottom, Right - 1, Left, Val2);
                true ->
                    {Matrix2, Val2}
                end,

            {Matrix4, Val4} = 
                if Left + 1 <= Right ->
                    fill_up(Matrix3, Left, Bottom - 1, Top + 1, Val3);
                true ->
                    {Matrix3, Val3}
                end,

            spiral_fill(Matrix4, N, Val4, Top + 1, Bottom - 1, Left + 1, Right - 1)
    end.

fill_right(Matrix, Row, ColStart, ColEnd, Val) ->
    fill_right_loop(Matrix, Row, ColStart, ColEnd, Val).

fill_right_loop(Matrix, Row, Col, ColEnd, Val) ->
    if
        Col > ColEnd ->
            {Matrix, Val};
        true ->
            NewMatrix = array:set({Row, Col}, Val, Matrix),
            fill_right_loop(NewMatrix, Row, Col + 1, ColEnd, Val + 1)
    end.

fill_down(Matrix, Col, RowStart, RowEnd, Val) ->
    fill_down_loop(Matrix, Col, RowStart, RowEnd, Val).

fill_down_loop(Matrix, Col, Row, RowEnd, Val) ->
    if
        Row > RowEnd ->
            {Matrix, Val};
        true ->
            NewMatrix = array:set({Row, Col}, Val, Matrix),
            fill_down_loop(NewMatrix, Col, Row + 1, RowEnd, Val + 1)
    end.

fill_left(Matrix, Row, ColStart, ColEnd, Val) ->
    fill_left_loop(Matrix, Row, ColStart, ColEnd, Val).

fill_left_loop(Matrix, Row, Col, ColEnd, Val) ->
    if
        Col < ColEnd ->
            {Matrix, Val};
        true ->
            NewMatrix = array:set({Row, Col}, Val, Matrix),
            fill_left_loop(NewMatrix, Row, Col - 1, ColEnd, Val + 1)
    end.

fill_up(Matrix, Col, RowStart, RowEnd, Val) ->
    fill_up_loop(Matrix, Col, RowStart, RowEnd, Val).

fill_up_loop(Matrix, Col, Row, RowEnd, Val) ->
    if
        Row < RowEnd ->
            {Matrix, Val};
        true ->
            NewMatrix = array:set({Row, Col}, Val, Matrix),
            fill_up_loop(NewMatrix, Col, Row - 1, RowEnd, Val + 1)
    end.

array_to_list_of_lists(Array, N, Row, Acc) ->
    if
        Row >= N ->
            lists:reverse(Acc);
        true ->
            RowList = array_row_to_list(Array, N, Row, 0, []),
            array_to_list_of_lists(Array, N, Row + 1, [RowList | Acc])
    end.

array_row_to_list(Array, N, Row, Col, Acc) ->
    if
        Col >= N ->
            lists:reverse(Acc);
        true ->
            Val = array:get({Row, Col}, Array),
            array_row_to_list(Array, N, Row, Col + 1, [Val | Acc])
    end.