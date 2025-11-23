-spec minimum_one_bit_operations(N :: integer()) -> integer().
minimum_one_bit_operations(N) ->
    minimum_one_bit_operations(N, 0).

minimum_one_bit_operations(0, Res) -> Res;
minimum_one_bit_operations(N, Res) ->
    B = highest_bit(N),
    M = (1 bsl B) - 1,
    minimum_one_bit_operations(N bxor M, Res + (1 bsl B)).

highest_bit(N) ->
    highest_bit(N, 0).

highest_bit(0, B) -> B - 1;
highest_bit(N, B) ->
    highest_bit(N bsr 1, B + 1).