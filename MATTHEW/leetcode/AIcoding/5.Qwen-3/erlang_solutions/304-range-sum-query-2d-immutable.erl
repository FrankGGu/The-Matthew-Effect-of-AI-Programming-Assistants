-module(range_sum_query_2d_immutable).
-export([new/1, sum_region/4]).

new(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Matrix)),
            Acc = array:new(Rows, {default, array:new(Cols, {default, 0})}),
            build_prefix(Acc, Matrix, 0, 0)
    end.

build_prefix(Acc, [], _, _) ->
    Acc;
build_prefix(Acc, [Row | Rest], I, J) ->
    build_row(Acc, Row, I, 0, J),
    build_prefix(Acc, Rest, I + 1, J).

build_row(Acc, [], _, _, _) ->
    Acc;
build_row(Acc, [Val | Rest], I, J, Cols) ->
    Current = array:get(I, Acc),
    NewCurrent = array:set(J, Val + get_value(Current, J - 1) + get_value(Acc, I - 1, J) - get_value(Acc, I - 1, J - 1), Current),
    NewAcc = array:set(I, NewCurrent, Acc),
    build_row(NewAcc, Rest, I, J + 1, Cols).

get_value(Array, I, J) when I < 0; J < 0 ->
    0;
get_value(Array, I, J) ->
    array:get(J, array:get(I, Array)).

sum_region(Prefix, R1, C1, R2, C2) ->
    A = get_value(Prefix, R2, C2),
    B = get_value(Prefix, R1 - 1, C2),
    C = get_value(Prefix, R2, C1 - 1),
    D = get_value(Prefix, R1 - 1, C1 - 1),
    A - B - C + D.