-module(solution).
-export([equal_frequency_submatrices/1]).

equal_frequency_submatrices(Grid) ->
    M = length(Grid),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Grid)),
            case N of
                0 -> 0;
                _ ->
                    InitialPrevPxRow = lists:duplicate(N, 0),
                    InitialPrevPyRow = lists:duplicate(N, 0),
                    count_submatrices_rows(Grid, 0, M, N, InitialPrevPxRow, InitialPrevPyRow, 0)
            end
    end.

count_submatrices_rows([], _R, _M, _N, _PrevPxRow, _PrevPyRow, AccCount) ->
    AccCount;
count_submatrices_rows([CurrentGridRow | RestGridRows], R, M, N, PrevPxRow, PrevPyRow, AccCount) ->
    {CurrentPxRow, CurrentPyRow, NewAccCount} =
        count_submatrices_cols(CurrentGridRow, R, N, PrevPxRow, PrevPyRow, 0, 0, 0, 0, AccCount, [], []),
    count_submatrices_rows(RestGridRows, R + 1, M, N, CurrentPxRow, CurrentPyRow, NewAccCount).

count_submatrices_cols([], _R, _N, _PrevPxRowList, _PrevPyRowList, _Px_R_C_minus_1, _Py_R_C_minus_1, _Px_R_minus_1_C_minus_1, _Py_R_minus_1_C_minus_1, AccCount, CurrentPxRowAcc, CurrentPyRowAcc) ->
    {lists:reverse(CurrentPxRowAcc), lists:reverse(CurrentPyRowAcc), AccCount};
count_submatrices_cols([Char | RestChars], R, N, PrevPxRowList, PrevPyRowList, Px_R_C_minus_1, Py_R_C_minus_1, Px_R_minus_1_C_minus_1, Py_R_minus_1_C_minus_1, AccCount, CurrentPxRowAcc, CurrentPyRowAcc) ->

    CurrentX = if Char == $X -> 1; true -> 0 end,
    CurrentY = if Char == $Y -> 1; true -> 0 end,

    {Px_R_minus_1_C, NextPrevPxRowList} = if R > 0 -> {hd(PrevPxRowList), tl(PrevPxRowList)}; true -> {0, PrevPxRowList} end,
    {Py_R_minus_1_C, NextPrevPyRowList} = if R > 0 -> {hd(PrevPyRowList), tl(PrevPyRowList)}; true -> {0, PrevPyRowList} end,

    NewPxVal = CurrentX + Px_R_minus_1_C + Px_R_C_minus_1 - Px_R_minus_1_C_minus_1,
    NewPyVal = CurrentY + Py_R_minus_1_C + Py_R_C_minus_1 - Py_R_minus_1_C_minus_1,

    NewAccCount = if NewPxVal == NewPyVal and NewPxVal > 0 -> AccCount + 1; true -> AccCount end,

    count_submatrices_cols(RestChars, R, N, NextPrevPxRowList, NextPrevPyRowList, NewPxVal, NewPyVal, Px_R_minus_1_C, Py_R_minus_1_C, NewAccCount, [NewPxVal | CurrentPxRowAcc], [NewPyVal | CurrentPyRowAcc]).