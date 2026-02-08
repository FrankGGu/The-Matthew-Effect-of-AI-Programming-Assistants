-module(solution).
-export([rotate/1]).

rotate(Box) ->
    Rows = length(Box),
    Cols = length(hd(Box)),
    NewBox = lists:map(fun(_) -> lists:duplicate(Rows, '.') end, lists:seq(1, Cols)),
    NewBoxFilled = fill_box(Box, NewBox, Rows, Cols, 0, 0),
    lists:map(fun(Row) -> lists:reverse(Row) end, NewBoxFilled).

fill_box([], NewBox, _, _, _, _) -> NewBox;
fill_box([Row | Rest], NewBox, Rows, Cols, R, C) ->
    fill_row(Row, NewBox, Rows, Cols, R, C, 0, 0, 0),
    fill_box(Rest, NewBox, Rows, Cols, R + 1, 0).

fill_row([], NewBox, Rows, Cols, R, C, Count, Obstacle, _) -> 
    fill_obstacles(NewBox, R, C, Count, Rows);
fill_row(['#' | T], NewBox, Rows, Cols, R, C, Count, Obstacle, _) -> 
    fill_obstacles(NewBox, R, C, Count, Rows),
    fill_row(T, NewBox, Rows, Cols, R, C, 0, R, 0);
fill_row(['.' | T], NewBox, Rows, Cols, R, C, Count, Obstacle, _) -> 
    fill_row(T, NewBox, Rows, Cols, R, C, Count + 1, Obstacle, 0).

fill_obstacles(NewBox, R, C, Count, Rows) ->
    lists:foreach(fun(I) -> 
        NewRow = (Rows - 1 - I),
        NewBox = lists:update_elem(C + I, lists:replace_elem(NewRow, '#', NewBox), NewBox)
    end, lists:seq(0, Count - 1)),
    NewBox.

lists:replace_elem(Index, Value, List) ->
    lists:mapfun(fun({I, E}) -> if I =:= Index -> Value; true -> E end end, lists:zip(lists:seq(0, length(List) - 1), List)).

lists:update_elem(Index, Value, List) ->
    lists:mapfun(fun({I, E}) -> if I =:= Index -> Value; true -> E end end, lists:zip(lists:seq(0, length(List) - 1), List)).