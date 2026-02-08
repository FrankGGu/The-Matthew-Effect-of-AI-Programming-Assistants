-module(spiral_matrix).
-export([spiral_order/1]).

spiral_order(Matrix) ->
    spiral_order(Matrix, []).

spiral_order([], Result) ->
    lists:reverse(Result);
spiral_order(Matrix, Result) ->
    [First | Rest] = Matrix,
    NewResult = Result ++ First,
    if
        Rest == [] ->
            spiral_order([], NewResult);
        true ->
            spiral_order(take_right(Rest), NewResult)
    end.

take_right([]) ->
    [];
take_right(Matrix) ->
    lists:map(fun Row -> lists:tl(Row) end, Matrix).

take_bottom([]) ->
    [];
take_bottom(Matrix) ->
    [lists:last(Matrix)] ++ take_left(lists:tl(Matrix)).

take_left([]) ->
    [];
take_left(Matrix) ->
    lists:map(fun Row -> lists:reverse(lists:tl(lists:reverse(Row))) end, Matrix).

take_top([]) ->
    [];
take_top(Matrix) ->
    [lists:first(Matrix)] ++ take_right(lists:tl(Matrix)).