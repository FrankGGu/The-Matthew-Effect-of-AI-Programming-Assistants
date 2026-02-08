-module(solution).
-export([equalizeColumns/1]).

equalizeColumns(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Result = lists:map(fun(Row) -> 
        Ones = count_ones(Row),
        Zeros = Cols - Ones,
        RowDiff = Ones - Zeros,
        ColDiff = lists:foldl(fun(Col, Acc) -> 
            RowOnes = count_ones(lists:sublist(Grid, Cols, Col)),
            RowZeros = Rows - RowOnes,
            Acc + (RowOnes - RowZeros)
        end, 0, lists:seq(1, Cols)),
        RowDiff - ColDiff
    end, Grid).

count_ones(List) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, List).