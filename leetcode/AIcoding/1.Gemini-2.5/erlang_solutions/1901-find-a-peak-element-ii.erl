-module(solution).
-export([findPeakGrid/1]).

findPeakGrid(Matrix) ->
    NumRows = length(Matrix),
    find_peak_grid_recursive(Matrix, 0, NumRows - 1).

find_peak_grid_recursive(Matrix, LowRow, HighRow) ->
    NumRows = length(Matrix),

    MidRow = LowRow + (HighRow - LowRow) div 2,

    CurrentRowList = lists:nth(MidRow + 1, Matrix),

    {MaxVal, MaxCol} = find_max_in_row_idx(CurrentRowList),

    UpVal = if MidRow > 0 -> 
                lists:nth(MaxCol + 1, lists:nth(MidRow, Matrix)); 
            true -> 
                -1 
            end,

    DownVal = if MidRow < NumRows - 1 -> 
                  lists:nth(MaxCol + 1, lists:nth(MidRow + 2, Matrix)); 
              true -> 
                  -1 
              end,

    if MaxVal > UpVal andalso MaxVal > DownVal ->
        [MidRow, MaxCol];
    else if UpVal > MaxVal ->
        find_peak_grid_recursive(Matrix, LowRow, MidRow - 1);
    else % DownVal > MaxVal
        find_peak_grid_recursive(Matrix, MidRow + 1, HighRow)
    end.

find_max_in_row_idx(RowList) ->
    find_max_in_row_idx(RowList, 0, -1, -1).

find_max_in_row_idx([], _CurrentIdx, MaxVal, MaxIdx) -> 
    {MaxVal, MaxIdx};
find_max_in_row_idx([H|T], CurrentIdx, MaxVal, MaxIdx) ->
    if H > MaxVal ->
        find_max_in_row_idx(T, CurrentIdx + 1, H, CurrentIdx);
    else
        find_max_in_row_idx(T, CurrentIdx + 1, MaxVal, MaxIdx)
    end.