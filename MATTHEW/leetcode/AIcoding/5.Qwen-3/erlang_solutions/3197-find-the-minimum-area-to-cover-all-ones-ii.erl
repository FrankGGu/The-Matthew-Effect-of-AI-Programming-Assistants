-module(solution).
-export([minimum_rectangle/1]).

minimum_rectangle(Grid) ->
    Rows = length(Grid),
    if Rows == 0 -> 0;
       true ->
            Cols = length(hd(Grid)),
            {MinRow, MaxRow, MinCol, MaxCol} = find_bounds(Grid, 0, Rows-1, 0, Cols-1),
            (MaxRow - MinRow + 1) * (MaxCol - MinCol + 1)
    end.

find_bounds(Grid, MinRow, MaxRow, MinCol, MaxCol) ->
    find_bounds(Grid, 0, MinRow, MaxRow, MinCol, MaxCol).

find_bounds([], _, MinRow, MaxRow, MinCol, MaxCol) ->
    {MinRow, MaxRow, MinCol, MaxCol};
find_bounds([Row | Rest], Index, MinRow, MaxRow, MinCol, MaxCol) ->
    find_row(Row, Index, 0, MinRow, MaxRow, MinCol, MaxCol),
    find_bounds(Rest, Index + 1, MinRow, MaxRow, MinCol, MaxCol).

find_row([], _, _, MinRow, MaxRow, MinCol, MaxCol) ->
    {MinRow, MaxRow, MinCol, MaxCol};
find_row([1 | Rest], RowIndex, ColIndex, MinRow, MaxRow, MinCol, MaxCol) ->
    NewMinRow = if RowIndex < MinRow -> RowIndex; true -> MinRow end,
    NewMaxRow = if RowIndex > MaxRow -> RowIndex; true -> MaxRow end,
    NewMinCol = if ColIndex < MinCol -> ColIndex; true -> MinCol end,
    NewMaxCol = if ColIndex > MaxCol -> ColIndex; true -> MaxCol end,
    find_row(Rest, RowIndex, ColIndex + 1, NewMinRow, NewMaxRow, NewMinCol, NewMaxCol);
find_row([_ | Rest], RowIndex, ColIndex, MinRow, MaxRow, MinCol, MaxCol) ->
    find_row(Rest, RowIndex, ColIndex + 1, MinRow, MaxRow, MinCol, MaxCol).