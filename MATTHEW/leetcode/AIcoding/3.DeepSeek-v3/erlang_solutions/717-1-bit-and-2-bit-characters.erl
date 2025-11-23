-spec is_one_bit_character(Bits :: [integer()]) -> boolean().
is_one_bit_character(Bits) ->
    is_one_bit_character(Bits, 0, length(Bits)).

is_one_bit_character(Bits, Index, Length) when Index >= Length - 1 ->
    Index == Length - 1;
is_one_bit_character(Bits, Index, Length) ->
    case lists:nth(Index + 1, Bits) of
        0 -> is_one_bit_character(Bits, Index + 1, Length);
        1 -> is_one_bit_character(Bits, Index + 2, Length)
    end.