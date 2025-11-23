-module(max_increase_keeping_skyline).
-export([max_increase_keeping_skyline/1]).

max_increase_keeping_skyline(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    RowMaxs = [max_in_row(Grid, Row) || Row <- lists:seq(1, Rows)],
    ColMaxs = [max_in_col(Grid, Col, Rows) || Col <- lists:seq(1, Cols)],

    lists:sum([min(lists:nth(Row, RowMaxs), lists:nth(Col, ColMaxs)) - get_grid_value(Grid, Row, Col) 
                || Row <- lists:seq(1, Rows), Col <- lists:seq(1, Cols)]).

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Rows, Cols}.

max_in_row(Grid, Row) ->
    RowValues = lists:nth(Row, Grid),
    lists:max(RowValues).

max_in_col(Grid, Col, Rows) ->
    ColValues = [get_grid_value(Grid, Row, Col) || Row <- lists:seq(1, Rows)],
    lists:max(ColValues).

get_grid_value(Grid, Row, Col) ->
    RowValues = lists:nth(Row, Grid),
    lists:nth(Col, RowValues).