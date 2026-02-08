-module(maximum_rows_covered_by_columns).
-export([maximumRows/2]).

maximumRows(Rows, Columns) ->
    RowsSet = lists:foldl(fun(Row, Acc) -> sets:from_list(Row, Acc) end, sets:new(), Rows),
    ColumnsSet = lists:foldl(fun(Col, Acc) -> sets:from_list(Col, Acc) end, sets:new(), Columns),
    MaxCovered = 0,
    lists:foldl(fun(Col, Acc) ->
        Covered = sets:intersection(RowsSet, ColumnsSet),
        sets:size(Covered) > Acc andalso Acc + 1
    end, MaxCovered, Columns).