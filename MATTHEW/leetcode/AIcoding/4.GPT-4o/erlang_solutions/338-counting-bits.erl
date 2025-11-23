-spec count_bits(N :: integer()) -> [integer()].
count_bits(N) -> count_bits(N, 0, [0]).

count_bits(0, _, Acc) -> lists:reverse(Acc);
count_bits(N, Index, Acc) ->
    count_bits(N div 2, Index + 1, [popcount(N) | Acc]).

popcount(0) -> 0;
popcount(N) -> N band 1 + popcount(N bsr 1).
