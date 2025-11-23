-spec trailing_zeroes(N :: integer()) -> integer().
trailing_zeroes(N) ->
    trailing_zeroes(N, 0).

trailing_zeroes(N, Count) when N >= 5 ->
    trailing_zeroes(N div 5, Count + (N div 5)).
trailing_zeroes(_, Count) ->
    Count.
