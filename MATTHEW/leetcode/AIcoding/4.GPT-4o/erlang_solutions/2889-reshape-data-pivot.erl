-module(solution).
-export([pivot/2]).

pivot(Rows, Cols) ->
    case length(Rows) of
        0 -> [];
        _ ->
            RowCount = length(Rows),
            ColCount = length(hd(Rows)),
            TotalCells = RowCount * ColCount,
            NewRowCount = div(TotalCells + Cols - 1, Cols),
            lists:map(fun(RowIndex) ->
                lists:sublist(lists:flatten(lists:map(fun(Row) -> lists:sublist(Row, RowIndex * Cols + 1, Cols) end, Rows)), RowIndex * Cols + 1, Cols)
            end, lists:seq(0, NewRowCount - 1))
    end.