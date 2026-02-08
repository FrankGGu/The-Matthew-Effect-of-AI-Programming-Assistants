-module(solution).
-export([modify_matrix/1]).

modify_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Matrix1 = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= 0 -> true; true -> false end end, Row) end, Matrix),
    lists:map(fun({Row, I}) -> lists:map(fun({Col, J}) -> if lists:nth(J + 1, lists:nth(I + 1, Matrix1)) orelse lists:nth(J + 1, Row) =:= 0 -> 0; true -> lists:nth(J + 1, Row) end end, lists:zip(Row, lists:seq(0, Cols - 1))) end, lists:zip(Matrix, lists:seq(0, Rows - 1)).