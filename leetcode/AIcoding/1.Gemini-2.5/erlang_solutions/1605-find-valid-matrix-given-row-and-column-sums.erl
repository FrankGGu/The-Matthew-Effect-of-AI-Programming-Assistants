-module(solution).
-export([findValidMatrix/2]).

findValidMatrix(RowSum, ColSum) ->
    build_rows_acc(RowSum, ColSum, []).

build_rows_acc([], _ColSums, AccMatrix) ->
    lists:reverse(AccMatrix);
build_rows_acc([CurrentRowSum | RestRowSums], ColSums, AccMatrix) ->
    {NewRow, UpdatedColSums} = build_current_row_recursive(CurrentRowSum, ColSums, [], []),
    build_rows_acc(RestRowSums, UpdatedColSums, [NewRow | AccMatrix]).

build_current_row_recursive(RemainingRowSum, [], UpdatedColSumsAcc, AccRow) ->
    {lists:reverse(AccRow), lists:reverse(UpdatedColSumsAcc)};
build_current_row_recursive(RemainingRowSum, [CurrentColSum | RestColSums], UpdatedColSumsAcc, AccRow) ->
    Val = min(RemainingRowSum, CurrentColSum),
    NewRemainingRowSum = RemainingRowSum - Val,
    NewCurrentColSum = CurrentColSum - Val,
    build_current_row_recursive(NewRemainingRowSum, RestColSums, [NewCurrentColSum | UpdatedColSumsAcc], [Val | AccRow]).