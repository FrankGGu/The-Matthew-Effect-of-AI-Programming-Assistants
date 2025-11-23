-spec has_alternating_bits(N :: integer()) -> boolean().
has_alternating_bits(N) ->
    Bits = N bxor (N bsr 1),
    (Bits + 1) band Bits =:= 0.