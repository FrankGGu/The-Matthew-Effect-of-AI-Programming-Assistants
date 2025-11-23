-module(solution).
-export([find_column_widths/1]).

find_column_widths(Grid) ->
    NumCols = length(hd(Grid)),
    InitialMaxColumnWidths = lists:duplicate(NumCols, 0),
    lists:foldl(fun(Row, AccMaxColumnWidths) ->
                    RowWidths = lists:map(fun(Num) -> calculate_width(Num) end, Row),
                    lists:zipwith(fun(CurrentMax, RowValWidth) ->
                                        max(CurrentMax, RowValWidth)
                                  end, AccMaxColumnWidths, RowWidths)
                end, InitialMaxColumnWidths, Grid).

calculate_width(Num) ->
    length(integer_to_list(Num)).