-module(solution).
-export([solve/1]).

solve(S) ->
    faulty_keyboard_acc(S, []).

faulty_keyboard_acc([H|T], Acc) when H == $i ->
    faulty_keyboard_acc(T, lists:reverse(Acc));
faulty_keyboard_acc([H|T], Acc) ->
    faulty_keyboard_acc(T, Acc ++ [H]);
faulty_keyboard_acc([], Acc) ->
    Acc.