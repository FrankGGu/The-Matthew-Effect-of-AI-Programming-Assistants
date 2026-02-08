-spec even_odd_bit(N :: integer()) -> [integer()].
even_odd_bit(N) ->
    Bin = integer_to_list(N, 2),
    Even = lists:sum([1 || {I, $1} <- lists:zip(lists:seq(0, length(Bin) - 1), lists:reverse(Bin)], I rem 2 == 0]),
    Odd = lists:sum([1 || {I, $1} <- lists:zip(lists:seq(0, length(Bin) - 1), lists:reverse(Bin)), I rem 2 == 1]),
    [Even, Odd].