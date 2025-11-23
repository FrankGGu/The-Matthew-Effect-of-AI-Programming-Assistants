-module(solution).
-export([increment_submatrices_by_one/2]).

increment_submatrices_by_one(Matrix, K) ->
    Dim = length(Matrix),
    RowLen = length(hd(Matrix)),
    UpdatedMatrix = lists:foldl(fun({i, Row}, Acc) ->
        lists:foldl(fun({j, Val}, AccRow) ->
            lists:foldl(fun({x, y}, AccAcc) ->
                if
                    x < i + K, y < j + K -> 
                        lists:nth(y + 1, AccAcc) =:= undefined -> 
                            lists:nth(y + 1, AccAcc) ++ [Val + 1]
                        ;
                            lists:nth(y + 1, AccAcc) ++ [lists:nth(y + 1, AccAcc) + 1]
                end,
                AccAcc
            end, AccRow, lists:seq(0, K - 1))
        end, Acc, lists:seq(0, RowLen - 1))
    end, Matrix, lists:seq(0, Dim - 1),
    UpdatedMatrix.