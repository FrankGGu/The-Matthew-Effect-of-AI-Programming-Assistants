-module(solution).
-export([is_one_bit_character/1]).

is_one_bit_character(Bits) ->
    is_one_bit_character(Bits, length(Bits) - 1, 0).

is_one_bit_character(Bits, Index, Count) when Index < 0 ->
    Count rem 2 =:= 0;
is_one_bit_character(Bits, Index, Count) ->
    case lists:nth(Index + 1, Bits) of
        0 -> is_one_bit_character(Bits, Index - 1, Count);
        1 -> is_one_bit_character(Bits, Index - 2, Count + 1)
    end.