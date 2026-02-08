-module(solution).
-export([valid_serials/1]).

valid_serials(Serials) ->
    lists:filter(fun(Serial) -> is_valid(Serial) end, Serials).

is_valid(Serial) ->
    Length = erlang:length(Serial),
    case Length rem 2 of
        0 ->
            check_even(Serial, 0);
        _ ->
            false
    end.

check_even([], _Sum) ->
    true;
check_even([D | Rest], Sum) ->
    Digit = erlang:list_to_integer([D]),
    case Sum + Digit of
        NewSum when NewSum < 10 ->
            check_even(Rest, NewSum);
        _ ->
            false
    end.