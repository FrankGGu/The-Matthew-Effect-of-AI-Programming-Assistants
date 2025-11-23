-module(minimum_moves_to_convert_string).
-export([min_moves/1]).

min_moves(S) ->
    min_moves(S, 0).

min_moves([], Acc) ->
    Acc;
min_moves([H | T], Acc) ->
    if
        H == $A ->
            min_moves(T, Acc + 1);
        true ->
            min_moves(T, Acc)
    end.