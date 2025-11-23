-spec isPowerOfTwo(N :: integer()) -> boolean().
isPowerOfTwo(N) ->
    N > 0 andalso (N band (N - 1)) == 0.