-spec count_bits(N :: integer()) -> [integer()].
count_bits(N) ->
    lists:reverse(count_bits(N, 0, [])).

count_bits(0, _Acc, Res) -> Res;
count_bits(N, Acc, Res) ->
    count_bits(N - 1, Acc + 1, [count_ones(Acc) | Res]).

count_ones(0) -> 0;
count_ones(N) -> count_ones(N band (N - 1)) + 1.