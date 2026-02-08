-spec trailing_zeroes(N :: integer()) -> integer().
trailing_zeroes(N) ->
    trailing_zeroes(N, 0).

trailing_zeroes(N, Acc) when N >= 5 ->
    trailing_zeroes(N div 5, Acc + N div 5);
trailing_zeroes(_, Acc) ->
    Acc.