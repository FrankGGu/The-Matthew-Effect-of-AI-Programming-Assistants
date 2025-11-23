-module(solution).
-export([numSubmatrixSumTarget/2]).

numSubmatrixSumTarget(Matrix, Target) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    numSubmatrixSumTarget_rows(0, Rows - 1, Matrix, Target, Cols, 0).

numSubmatrixSumTarget_rows(TopRow, MaxRowIdx, Matrix, Target, Cols, AccCount) when TopRow =< MaxRowIdx ->
    InitialColSums = lists:duplicate(Cols, 0),
    NewAccCount = numSubmatrixSumTarget_bottom_rows(TopRow, TopRow, MaxRowIdx, Matrix, Target, Cols, InitialColSums, AccCount),
    numSubmatrixSumTarget_rows(TopRow + 1, MaxRowIdx, Matrix, Target, Cols, NewAccCount);
numSubmatrixSumTarget_rows(_TopRow, _MaxRowIdx, _Matrix, _Target, _Cols, AccCount) ->
    AccCount.

numSubmatrixSumTarget_bottom_rows(_TopRow, BottomRow, MaxRowIdx, Matrix, Target, Cols, CurrentColSums, AccCount) when BottomRow =< MaxRowIdx ->
    CurrentMatrixRow = lists:nth(BottomRow + 1, Matrix),
    UpdatedColSums = lists:zipwith(fun(A, B) -> A + B end, CurrentColSums, CurrentMatrixRow),
    CountForThisSubmatrix = count_subarrays_with_sum(UpdatedColSums, Target),
    NewAccCount = AccCount + CountForThisSubmatrix,
    numSubmatrixSumTarget_bottom_rows(_TopRow, BottomRow + 1, MaxRowIdx, Matrix, Target, Cols, UpdatedColSums, NewAccCount);
numSubmatrixSumTarget_bottom_rows(_TopRow, _BottomRow, _MaxRowIdx, _Matrix, _Target, _Cols, _CurrentColSums, AccCount) ->
    AccCount.

count_subarrays_with_sum(List, Target) ->
    count_subarrays_with_sum_acc(List, Target, 0, #{0 => 1}, 0).

count_subarrays_with_sum_acc([], _Target, _CurrentSum, _PrefixSums, Count) -> Count;
count_subarrays_with_sum_acc([H|T], Target, CurrentSum, PrefixSums, Count) ->
    NewCurrentSum = CurrentSum + H,
    CountToAdd = maps:get(NewCurrentSum - Target, PrefixSums, 0),
    NewCount = Count + CountToAdd,
    NewPrefixSums = maps:update_with(NewCurrentSum, fun(V) -> V + 1 end, 1, PrefixSums),
    count_subarrays_with_sum_acc(T, Target, NewCurrentSum, NewPrefixSums, NewCount).