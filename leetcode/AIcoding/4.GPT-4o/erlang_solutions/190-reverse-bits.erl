%% Reverse bits of a given 32-bit unsigned integer.

-spec reverse_bits(N :: integer()) -> integer().
reverse_bits(N) ->
    reverse_bits(N, 0, 32).

reverse_bits(0, Result, _) -> Result;
reverse_bits(N, Result, 0) -> Result;
reverse_bits(N, Result, Count) ->
    reverse_bits(N bsr 1, (Result bsl 1) bor (N band 1), Count - 1).
