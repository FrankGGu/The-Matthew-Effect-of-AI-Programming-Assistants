-module(solution).
-export([count_cells/2]).

count_cells(Grid, Substrings) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    SubstringSet = lists:usort(Substrings),
    CellCounts = lists:map(fun(Substring) -> count_cell(Grid, Substring, Rows, Columns) end, SubstringSet),
    lists:sum(CellCounts).

count_cell(Grid, Substring, Rows, Columns) ->
    HorizontalCount = count_horizontal(Grid, Substring, Rows, Columns),
    VerticalCount = count_vertical(Grid, Substring, Rows, Columns),
    HorizontalCount + VerticalCount.

count_horizontal(Grid, Substring, Rows, Columns) ->
    lists:sum(lists:map(fun(Row) -> count_occurrences(Row, Substring) end, Grid)).

count_vertical(Grid, Substring, Rows, Columns) ->
    Transposed = lists:map(fun(I) -> lists:nth(I + 1, Grid) end, lists:seq(0, Columns - 1)),
    lists:sum(lists:map(fun(Column) -> count_occurrences(Column, Substring) end, Transposed)).

count_occurrences(List, Substring) ->
    count_occurrences(List, Substring, 0).

count_occurrences([], _Substring, Count) ->
    Count;
count_occurrences(List, Substring, Count) ->
    case lists:prefix(Substring, List) of
        true -> count_occurrences(tl(List), Substring, Count + 1);
        false -> count_occurrences(tl(List), Substring, Count)
    end.