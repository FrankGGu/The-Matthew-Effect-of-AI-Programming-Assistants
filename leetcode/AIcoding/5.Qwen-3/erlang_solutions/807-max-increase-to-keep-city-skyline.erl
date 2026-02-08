-module(solution).
-export([max_increase_kingdom/1]).

max_increase_kingdom(Grid) ->
    Rows = lists:map(fun(Row) -> lists:reverse(Row) end, Grid),
    Cols = lists:zipwith(fun lists:reverse/1, Grid),
    max_increase_kingdom(Grid, Rows, Cols, 0).

max_increase_kingdom([], _, _, Acc) ->
    Acc;
max_increase_kingdom([Row | RestRows], Rows, Cols, Acc) ->
    max_increase_kingdom(RestRows, Rows, Cols, Acc + max_row_increase(Row, Rows, Cols)).

max_row_increase([], _, _) ->
    0;
max_row_increase([H | T], Rows, Cols) ->
    RowIndex = length(Rows) - length(Rows),
    ColIndex = length(Cols) - length(Cols),
    MaxRow = lists:max(lists:nth(RowIndex + 1, Rows)),
    MaxCol = lists:max(lists:nth(ColIndex + 1, Cols)),
    Increase = min(MaxRow, MaxCol) - H,
    Increase + max_row_increase(T, Rows, Cols).