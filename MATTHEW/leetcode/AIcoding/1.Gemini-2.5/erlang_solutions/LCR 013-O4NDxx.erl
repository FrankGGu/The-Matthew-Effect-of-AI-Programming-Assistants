-module(num_matrix).
-export([new/1, sum_region/5]).

new(Matrix) ->
    M = length(Matrix),
    N = if M > 0 -> length(hd(Matrix)); else -> 0 end,

    ZeroRow = lists:duplicate(N + 1, 0),

    {ReversedPSRows, _LastPSRow} = lists:foldl(
        fun(MatRow, {AccPSRows, PrevPSRow}) ->
            CurrentPSRow = build_ps_row(MatRow, PrevPSRow),
            {[CurrentPSRow | AccPSRows], CurrentPSRow}
        end,
        {[], ZeroRow},
        Matrix
    ),
    lists:reverse([ZeroRow | ReversedPSRows]).

build_ps_row(MatRow, PrevPSRow) ->
    ZippedData = lists:zip(MatRow, lists:zip(PrevPSRow, tl(PrevPSRow))),

    {ReversedPSRow, _LastCurrentRowSum} = lists:foldl(
        fun({MatVal, {PrevPS_JMinus1, PrevPS_J}}, {AccPSRow, CurrentRowSum}) ->
            NewCurrentRowSum = CurrentRowSum + MatVal,
            NewPSVal = NewCurrentRowSum + PrevPS_J - PrevPS_JMinus1,
            {[NewPSVal | AccPSRow], NewCurrentRowSum}
        end,
        {[], 0},
        ZippedData
    ),
    lists:reverse([0 | ReversedPSRow]).

sum_region(PS, R1, C1, R2, C2) ->
    ValR2C2 = get_ps_val(PS, R2 + 1, C2 + 1),
    ValR1C2 = get_ps_val(PS, R1, C2 + 1),
    ValR2C1 = get_ps_val(PS, R2 + 1, C1),
    ValR1C1 = get_ps_val(PS, R1, C1),
    ValR2C2 - ValR1C2 - ValR2C1 + ValR1C1.

get_ps_val(PS, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, PS)).