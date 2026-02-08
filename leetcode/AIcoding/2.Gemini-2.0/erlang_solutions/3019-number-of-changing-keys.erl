-module(number_of_changing_keys).
-export([number_of_changing_keys/1]).

number_of_changing_keys(S) ->
    number_of_changing_keys(S, undefined, 0).

number_of_changing_keys([], _, Acc) ->
    Acc;
number_of_changing_keys([H|T], undefined, Acc) ->
    number_of_changing_keys(T, to_lower(H), Acc);
number_of_changing_keys([H|T], Prev, Acc) ->
    L = to_lower(H),
    if
        L =/= Prev ->
            number_of_changing_keys(T, L, Acc + 1);
        true ->
            number_of_changing_keys(T, Prev, Acc)
    end.

to_lower(C) ->
    case C of
        $A..$Z -> C + 32;
        _ -> C
    end.