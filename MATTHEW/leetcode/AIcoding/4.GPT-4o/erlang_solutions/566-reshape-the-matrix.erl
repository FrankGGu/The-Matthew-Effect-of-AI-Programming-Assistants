-module(solution).
-export([matrix_reshape/3]).

matrix_reshape(Matrix, R, C) ->
    {Rows, Cols} = lists:tuple_size(Matrix),
    Total = Rows * Cols,
    if 
        Total =:= R * C -> 
            Reshaped = reshape(Matrix, R, C, 0, 0, []),
            lists:reverse(Reshaped);
        true -> 
            Matrix
    end.

reshape(_, R, C, R, C, Acc) -> Acc;
reshape(Matrix, R, C, Row, Col, Acc) ->
    Element = element((Row * lists:tuple_size(element(Row + 1, Matrix)) + Col + 1), Matrix),
    reshape(Matrix, R, C, Row + (Col + 1) div C, (Col + 1) rem C, [Element | Acc]).