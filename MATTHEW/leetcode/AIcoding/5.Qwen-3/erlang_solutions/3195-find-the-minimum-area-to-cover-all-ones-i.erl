-module(solution).
-export([minimum_rectangle/1]).

minimum_rectangle(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            {MinRow, MaxRow, MinCol, MaxCol} = find_bounds(Grid, 0, 0, 0, 0, 0, 0),
            if
                MinRow == 0 andalso MaxRow == 0 andalso MinCol == 0 andalso MaxCol == 0 -> 0;
                true -> (MaxRow - MinRow + 1) * (MaxCol - MinCol + 1)
            end
    end.

find_bounds([], _, _, MinRow, MaxRow, MinCol, MaxCol) ->
    {MinRow, MaxRow, MinCol, MaxCol};
find_bounds([Row | Rest], RowIdx, ColIdx, MinRow, MaxRow, MinCol, MaxCol) ->
    case Row of
        [] ->
            find_bounds(Rest, RowIdx + 1, 0, MinRow, MaxRow, MinCol, MaxCol);
        [Val | Tail] ->
            if
                Val == 1 ->
                    NewMinRow = if RowIdx < MinRow -> RowIdx; true -> MinRow end,
                    NewMaxRow = if RowIdx > MaxRow -> RowIdx; true -> MaxRow end,
                    NewMinCol = if ColIdx < MinCol -> ColIdx; true -> MinCol end,
                    NewMaxCol = if ColIdx > MaxCol -> ColIdx; true -> MaxCol end,
                    find_bounds([Row | Rest], RowIdx, ColIdx + 1, NewMinRow, NewMaxRow, NewMinCol, NewMaxCol);
                true ->
                    find_bounds([Row | Rest], RowIdx, ColIdx + 1, MinRow, MaxRow, MinCol, MaxCol)
            end
    end.