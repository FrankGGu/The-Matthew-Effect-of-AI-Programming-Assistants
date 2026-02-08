-module(solution).
-export([matrix_sum/1]).

matrix_sum(Matrix) ->
    lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(X, A) -> A + X end, Acc, Row)
    end, 0, Matrix).