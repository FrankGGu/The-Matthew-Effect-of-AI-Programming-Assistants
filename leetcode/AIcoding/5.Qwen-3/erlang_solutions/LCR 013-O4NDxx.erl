-module(num_matrix).
-export([new/1, sum_region/4]).

new(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Acc = array:new(Cols * Rows, {default, 0}),
    build(Acc, Matrix, 0, 0).

build(Acc, [], _, _) ->
    Acc;
build(Acc, [Row | Rest], R, C) ->
    build_row(Acc, Row, R, C, 0),
    build(Acc, Rest, R + 1, 0).

build_row(Acc, [], _, _, _) ->
    Acc;
build_row(Acc, [Val | Rest], R, C, Index) ->
    NewAcc = array:set(Index, Val, Acc),
    build_row(NewAcc, Rest, R, C + 1, Index + 1).

sum_region(This, Row1, Col1, Row2, Col2) ->
    Sum = get_sum(This, Row2, Col2) - get_sum(This, Row1 - 1, Col2) - get_sum(This, Row2, Col1 - 1) + get_sum(This, Row1 - 1, Col1 - 1),
    Sum.

get_sum(This, R, C) ->
    if
        R < 0 orelse C < 0 -> 0;
        true -> array:get(R * length(This) + C, This)
    end.