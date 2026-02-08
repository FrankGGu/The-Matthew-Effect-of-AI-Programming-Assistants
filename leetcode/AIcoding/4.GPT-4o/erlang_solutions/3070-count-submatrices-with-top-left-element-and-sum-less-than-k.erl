-module(solution).
-export([count_submatrices/2]).

count_submatrices(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    TotalCount = lists:foldl(fun (RowIdx, Acc) ->
        lists:foldl(fun (ColIdx, Acc1) ->
            count_submatrices_from(Matrix, RowIdx, ColIdx, K) + Acc1
        end, Acc, lists:seq(0, Cols - 1))
    end, 0, lists:seq(0, Rows - 1)),
    TotalCount.

count_submatrices_from(Matrix, RowIdx, ColIdx, K) ->
    Sum = 0,
    Count = count_submatrices_helper(Matrix, RowIdx, ColIdx, K, 0, Sum, 0),
    Count.

count_submatrices_helper(Matrix, RowIdx, ColIdx, K, CurrSum, Count, Acc) ->
    case RowIdx >= length(Matrix) orelse ColIdx >= length(hd(Matrix)) of
        true -> Acc;
        false ->
            NewSum = CurrSum + lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Matrix)),
            NewAcc = if
                NewSum < K -> Acc + 1;
                true -> Acc
            end,
            count_submatrices_helper(Matrix, RowIdx + 1, ColIdx, K, NewSum, Count, NewAcc) + 
            count_submatrices_helper(Matrix, RowIdx, ColIdx + 1, K, CurrSum, Count, NewAcc)
    end.