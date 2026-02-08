-spec reverse_bits(N :: non_neg_integer()) -> non_neg_integer().
reverse_bits(N) ->
    reverse_bits(N, 0, 32).

reverse_bits(0, Acc, 0) ->
    Acc;
reverse_bits(N, Acc, BitsLeft) ->
    reverse_bits(N bsr 1, (Acc bsl 1) bor (N band 1), BitsLeft - 1).