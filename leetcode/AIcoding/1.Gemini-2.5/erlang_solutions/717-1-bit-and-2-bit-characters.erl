-module(solution).
-export([is_one_bit_character/1]).

is_one_bit_character(Bits) ->
    check(Bits).

check([]) ->
    false;
check([0]) ->
    true;
check([0 | Rest]) ->
    check(Rest);
check([1, _ | Rest]) ->
    check(Rest).