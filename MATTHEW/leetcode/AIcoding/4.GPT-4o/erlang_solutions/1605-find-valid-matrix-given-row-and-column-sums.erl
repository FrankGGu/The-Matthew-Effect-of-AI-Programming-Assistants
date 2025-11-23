-module(solution).
-export([restoreMatrix/2]).

restoreMatrix(RowSums, ColSums) ->
    Rows = length(RowSums),
    Cols = length(ColSums),
    Matrix = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    restore_matrix(RowSums, ColSums, Matrix, 0, 0).

restore_matrix(_, [], Matrix, _, _) -> Matrix;
restore_matrix([], _, Matrix, _, _) -> Matrix;
restore_matrix(RowSums, ColSums, Matrix, RowIdx, ColIdx) ->
    RowSum = lists:nth(RowIdx + 1, RowSums),
    ColSum = lists:nth(ColIdx + 1, ColSums),
    Value = min(RowSum, ColSum),
    NewRowSums = lists:sublist(RowSums, 1, RowIdx) ++ [RowSum - Value] ++ lists:sublist(RowSums, RowIdx + 2, length(RowSums) - RowIdx - 1),
    NewColSums = lists:sublist(ColSums, 1, ColIdx) ++ [ColSum - Value] ++ lists:sublist(ColSums, ColIdx + 2, length(ColSums) - ColIdx - 1),
    NewMatrix = lists:replace(Matrix, RowIdx, lists:replace(lists:nth(RowIdx + 1, Matrix), ColIdx, Value)),
    if
        ColIdx + 1 < length(ColSums) ->
            restore_matrix(RowSums, NewColSums, NewMatrix, RowIdx, ColIdx + 1);
        RowIdx + 1 < length(RowSums) ->
            restore_matrix(NewRowSums, ColSums, NewMatrix, RowIdx + 1, 0);
        true -> 
            NewMatrix
    end.