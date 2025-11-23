-module(transpose_matrix).
-export([transpose/1]).

transpose(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    lists:map(fun(Col) -> 
                      lists:map(fun(Row) -> lists:nth(Col, lists:nth(Row, Matrix)) end, lists:seq(1, Rows))
              end, lists:seq(1, Cols)).