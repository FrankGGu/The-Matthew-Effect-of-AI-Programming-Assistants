-module(solution).
-export([find_column_widths/1]).

find_column_widths(Grid) ->
    ColumnWidths = lists:map(fun(ColumnIndex) ->
        lists:max(lists:map(fun(Row) -> 
            string:length(Row) 
        end, lists:map(fun(Row) -> lists:nth(ColumnIndex + 1, Row) end, Grid)))
    end, lists:seq(0, length(hd(Grid)) - 1)),
    ColumnWidths.