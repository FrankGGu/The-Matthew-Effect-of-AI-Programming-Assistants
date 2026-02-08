-spec min_array(N :: integer(), X :: integer()) -> [integer()].
min_array(N, X) ->
    [X] ++ lists:seq(1, N - 1).