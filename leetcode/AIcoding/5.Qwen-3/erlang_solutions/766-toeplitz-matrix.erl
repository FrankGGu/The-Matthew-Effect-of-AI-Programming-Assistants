-module(toeplitz_matrix).
-export([is_toeplitz_matrix/1]).

is_toeplitz_matrix(Matrix) ->
    is_toeplitz_matrix(Matrix, 0, 0, length(Matrix), length(hd(Matrix))).

is_toeplitz_matrix(_, _, Col, _, MaxCol) when Col >= MaxCol -> true;
is_toeplitz_matrix(_, Row, _, MaxRow, _) when Row >= MaxRow -> true;
is_toeplitz_matrix(Matrix, Row, Col, MaxRow, MaxCol) ->
    Current = lists:nth(Row + 1, Matrix),
    NextRow = Row + 1,
    NextCol = Col + 1,
    if
        NextRow < MaxRow andalso NextCol < MaxCol ->
            NextVal = lists:nth(NextCol + 1, lists:nth(NextRow + 1, Matrix)),
            Val = lists:nth(Col + 1, Current),
            if Val == NextVal -> is_toeplitz_matrix(Matrix, Row + 1, Col, MaxRow, MaxCol);
               true -> false
            end;
        true -> is_toeplitz_matrix(Matrix, Row + 1, Col, MaxRow, MaxCol)
    end.