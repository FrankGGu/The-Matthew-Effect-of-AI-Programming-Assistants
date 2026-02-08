-module(valid_sudoku).
-export([is_valid_sudoku/1]).

is_valid_sudoku(Board) ->
    check_rows(Board) andalso check_cols(Board) andalso check_boxes(Board).

check_rows(Board) ->
    lists:all(fun(Row) -> is_valid_unit(Row) end, Board).

check_cols(Board) ->
    lists:all(fun(Col) -> is_valid_unit(Col) end, transpose(Board)).

check_boxes(Board) ->
    lists:all(fun(Box) -> is_valid_unit(Box) end, boxes(Board)).

is_valid_unit(Unit) ->
    Filtered = lists:filter(fun(X) -> X /= '.' end, Unit),
    lists:length(Filtered) == lists:length(lists:usort(Filtered)).

transpose(Board) ->
    lists:zip(Board).

boxes(Board) ->
    [get_box(Board, Row, Col) || Row <- [0, 3, 6], Col <- [0, 3, 6]].

get_box(Board, RowStart, ColStart) ->
    [lists:nth(ColStart + Col, lists:nth(RowStart + Row, Board)) || Row <- lists:seq(1, 3), Col <- lists:seq(1, 3)].