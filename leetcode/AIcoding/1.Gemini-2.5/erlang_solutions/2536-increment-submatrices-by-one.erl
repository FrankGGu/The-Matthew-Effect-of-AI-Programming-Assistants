-module(solution).
-export([range_add_submatrices/2]).

range_add_submatrices(N, Queries) ->
    InitialRow = array:new([{size, N + 1}, {default, 0}]),
    DiffMatrix = array:from_list([InitialRow || _ <- lists:seq(0, N)]),

    UpdateCell = fun(Matrix, RowIdx, ColIdx, Delta) ->
        Row = array:get(RowIdx, Matrix),
        CurrentVal = array:get(ColIdx, Row),
        NewRow = array:set(ColIdx, CurrentVal + Delta, Row),
        array:set(RowIdx, NewRow, Matrix)
    end,

    UpdatedDiffMatrix = lists:foldl(
        fun([R1, C1, R2, C2], CurrentDiffMatrix) ->
            NextMatrix1 = UpdateCell(CurrentDiffMatrix, R1, C1, 1),
            NextMatrix2 = if C2 + 1 < N + 1 -> UpdateCell(NextMatrix1, R1, C2 + 1, -1); true -> NextMatrix1 end,
            NextMatrix3 = if R2 + 1 < N + 1 -> UpdateCell(NextMatrix2, R2 + 1, C1, -1); true -> NextMatrix2 end,
            NextMatrix4 = if R2 + 1 < N + 1 andalso C2 + 1 < N + 1 -> UpdateCell(NextMatrix3, R2 + 1, C2 + 1, 1); true -> NextMatrix3 end,
            NextMatrix4
        end,
        DiffMatrix,
        Queries
    ),

    ResultInitialRow = array:new([{size, N}, {default, 0}]),
    ResultMatrix = array:from_list([ResultInitialRow || _ <- lists:seq(0, N - 1)]),

    FinalResultMatrix = calculate_prefix_sum(N, UpdatedDiffMatrix, ResultMatrix, 0, 0),

    array:to_list(array:map(fun(_Idx, RowArray) -> array:to_list(RowArray) end, FinalResultMatrix)).

calculate_prefix_sum(N, DiffMatrix, CurrentResultMatrix, R, C) when R < N ->
    DiffVal = array:get(C, array:get(R, DiffMatrix)),

    PrevRowVal = if R > 0 -> array:get(C, array:get(R - 1, CurrentResultMatrix)); true -> 0 end,
    PrevColVal = if C > 0 -> array:get(C - 1, array:get(R, CurrentResultMatrix)); true -> 0 end,
    PrevDiagVal = if R > 0 andalso C > 0 -> array:get(C - 1, array:get(R - 1, CurrentResultMatrix)); true -> 0 end,

    CurrentCellVal = DiffVal + PrevRowVal + PrevColVal - PrevDiagVal,

    RowR = array:get(R, CurrentResultMatrix),
    NewRowR = array:set(C, CurrentCellVal, RowR),
    NextResultMatrix = array:set(R, NewRowR, CurrentResultMatrix),

    if C + 1 < N ->
        calculate_prefix_sum(N, DiffMatrix, NextResultMatrix, R, C + 1);
    true ->
        calculate_prefix_sum(N, DiffMatrix, NextResultMatrix, R + 1, 0)
    end;
calculate_prefix_sum(_N, _DiffMatrix, FinalResultMatrix, _R, _C) ->
    FinalResultMatrix.