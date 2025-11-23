-spec count_bits(N :: integer()) -> [integer()].
count_bits(N) ->
    lists:reverse(count_bits(N, [0], 1)).

count_bits(0, Acc, _) -> Acc;
count_bits(N, Acc, I) when I > N -> lists:reverse(Acc);
count_bits(N, Acc, I) ->
    count_bits(N, [hd(Acc) + 1 | Acc], I + 1).