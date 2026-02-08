-module(rotating_box).
-export([rotate_the_box/1]).

rotate_the_box(Items) ->
    Rows = length(Items),
    Cols = length(hd(Items)),
    Grid = lists:foldl(fun(Row, Acc) -> [Row | Acc] end, [], Items),
    RotateGrid = rotate(Grid, Rows, Cols),
    lists:map(fun(Row) -> lists:reverse(Row) end, RotateGrid).

rotate(Grid, Rows, Cols) ->
    rotate(Grid, Rows, Cols, 0, []).

rotate([], _, _, _, Acc) ->
    Acc;
rotate(Grid, Rows, Cols, Col, Acc) ->
    NewRow = lists:foldl(fun(Row, Acc2) -> 
        [element(Col + 1, Row) | Acc2] 
    end, [], Grid),
    rotate(Grid, Rows, Cols, Col + 1, [NewRow | Acc]).

rotate_column([], _, _) ->
    [];
rotate_column([H | T], Count, Result) ->
    if
        H == 32 -> 
            [H | rotate_column(T, Count - 1, Result)];
        true ->
            [H | rotate_column(T, Count, Result)]
    end.

sort_row([]) ->
    [];
sort_row([H | T]) ->
    {Solid, Empty} = lists:partition(fun(X) -> X == 35 end, [H | T]),
    lists:append(Solid, Empty).

rotate_grid([], _) ->
    [];
rotate_grid([Row | Rest], Cols) ->
    SortedRow = sort_row(Row),
    [SortedRow | rotate_grid(Rest, Cols)].

rotate([], _, _) ->
    [];
rotate(Grid, Rows, Cols) ->
    rotate_grid(Grid, Cols).