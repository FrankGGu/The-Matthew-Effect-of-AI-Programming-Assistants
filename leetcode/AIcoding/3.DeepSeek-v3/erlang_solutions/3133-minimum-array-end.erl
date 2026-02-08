-spec min_array_end(N :: integer(), X1 :: integer(), X2 :: integer()) -> integer().
min_array_end(N, X1, X2) ->
    lists:min([X1, X2]) * (1 bsl (N - 1)) + ((1 bsl (N - 1)) - 1).