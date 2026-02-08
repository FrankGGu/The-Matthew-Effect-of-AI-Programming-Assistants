-spec fraction(cont :: [integer()]) -> [integer()].
fraction(Cont) ->
    fraction_helper(Cont, 0, 1).

fraction_helper([], A, B) ->
    [A, B];
fraction_helper([N | Rest], A, B) ->
    fraction_helper(Rest, B, N * B + A).