-module(solution).
-export([construct_product_matrix/2]).

construct_product_matrix(MatrixA, MatrixB) ->
    RowsA = length(MatrixA),
    ColsA = length(hd(MatrixA)),
    ColsB = length(hd(MatrixB)),
    lists:map(fun(RowA) ->
        lists:map(fun(j) ->
            lists:foldl(fun(RowB, Acc) -> 
                Acc + (RowA * lists:nth(j, RowB)) 
            end, 0, MatrixB)
        end, [], lists:seq(1, ColsB))
    end, MatrixA).