-module(solution).
-export([largest_1_bordered_square/1]).

largest_1_bordered_square(Grid) ->
    R = length(Grid),
    if R == 0 -> 0; true -> ok end,
    C = length(hd(Grid)),
    if C == 0 -> 0; true -> ok end,

    Left = array:new([{fixed, true}, {size, R}]),
    Up = array:new([{fixed, true}, {size, R}]),

    {FinalLeft, FinalUp} = populate_dp_tables(Grid, R, C, 0, Left, Up),

    find_largest_square(R, C, FinalLeft, FinalUp, 0).

populate_dp_tables(Grid, R, C, RowIdx, LeftAcc, UpAcc) when RowIdx < R ->
    Row = lists:nth(RowIdx + 1, Grid),

    CurrentLeftRow = array:new([{fixed, true}, {size, C}]),
    CurrentUpRow = array:new([{fixed, true}, {size, C}]),

    {UpdatedLeftRow, UpdatedUpRow} = populate_dp_cols(Row, R, C, RowIdx, 0, UpAcc, CurrentLeftRow, CurrentUpRow),

    NewLeftAcc = array:set(RowIdx, UpdatedLeftRow, LeftAcc),
    NewUpAcc = array:set(RowIdx, UpdatedUpRow, UpAcc),

    populate_dp_tables(Grid, R, C, RowIdx + 1, NewLeftAcc, NewUpAcc);
populate_dp_tables(_, _, _, _, LeftAcc, UpAcc) ->
    {LeftAcc, UpAcc}.

populate_dp_cols(Row, R, C, RowIdx, ColIdx, UpAcc, LeftRowAcc, UpRowAcc) when ColIdx < C ->
    Val = lists:nth(ColIdx + 1, Row),

    LeftVal = 0,
    UpVal = 0,

    if Val == 1 ->
        PrevLeft = if ColIdx > 0 -> array:get(ColIdx - 1, LeftRowAcc); true -> 0 end,
        PrevUp = if RowIdx > 0 -> array:get(ColIdx, array:get(RowIdx - 1, UpAcc)); true -> 0 end,
        LeftVal = PrevLeft + 1,
        UpVal = PrevUp + 1;
    true ->
        ok
    end,

    NewLeftRowAcc = array:set(ColIdx, LeftVal, LeftRowAcc),
    NewUpRowAcc = array:set(ColIdx, UpVal, UpRowAcc),

    populate_dp_cols(Row, R, C, RowIdx, ColIdx + 1, UpAcc, NewLeftRowAcc, NewUpRowAcc);
populate_dp_cols(_, _, _, _, _, _, LeftRowAcc, UpRowAcc) ->
    {LeftRowAcc, UpRowAcc}.

find_largest_square(R, C, LeftTable, UpTable, MaxSide) ->
    find_largest_square_rows(R, C, 0, LeftTable, UpTable, MaxSide).

find_largest_square_rows(R, C, RowIdx, LeftTable, UpTable, MaxSide) when RowIdx < R ->
    NewMaxSide = find_largest_square_cols(R, C, RowIdx, 0, LeftTable, UpTable, MaxSide),
    find_largest_square_rows(R, C, RowIdx + 1, LeftTable, UpTable, NewMaxSide);
find_largest_square_rows(_, _, _, _, _, MaxSide) ->
    MaxSide * MaxSide.

find_largest_square_cols(R, C, RowIdx, ColIdx, LeftTable, UpTable, MaxSide) when ColIdx < C ->
    CurrentLeftRow = array:get(RowIdx, LeftTable),
    CurrentUpRow = array:get(RowIdx, UpTable),
    LeftVal = array:get(ColIdx, CurrentLeftRow),
    UpVal = array:get(ColIdx, CurrentUpRow),

    K_max = min(LeftVal, UpVal),
    NewMaxSide = check_sides(RowIdx, ColIdx, K_max, LeftTable, UpTable, MaxSide),

    find_largest_square_cols(R, C, RowIdx, ColIdx + 1, LeftTable, UpTable, NewMaxSide);
find_largest_square_cols(_, _, _, _, _, _, MaxSide) ->
    MaxSide.

check_sides(R_idx, C_idx, K, LeftTable, UpTable, CurrentMaxSide) when K > CurrentMaxSide ->
    LeftAtTopRightRow = array:get(R_idx - K + 1, LeftTable),
    LeftAtTopRight = array:get(C_idx, LeftAtTopRightRow),

    UpAtBottomLeftRow = array:get(R_idx, UpTable),
    UpAtBottomLeft = array:get(C_idx - K + 1, UpAtBottomLeftRow),

    if LeftAtTopRight >= K andalso UpAtBottomLeft >= K ->
        check_sides(R_idx, C_idx, K - 1, LeftTable, UpTable, K);
    true ->
        check_sides(R_idx, C_idx, K - 1, LeftTable, UpTable, CurrentMaxSide)
    end;
check_sides(_, _, _, _, _, CurrentMaxSide) ->
    CurrentMaxSide.