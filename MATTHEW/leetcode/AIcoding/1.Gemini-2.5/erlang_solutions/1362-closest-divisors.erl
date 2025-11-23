-spec closest_divisors(Num :: integer()) -> [integer(), integer()].
closest_divisors(Num) ->
    N1 = Num + 1,
    N2 = Num + 2,

    {A1, B1} = find_closest_pair(N1),
    {A2, B2} = find_closest_pair(N2),

    Diff1 = abs(A1 - B1),
    Diff2 = abs(A2 - B2),

    if
        Diff1 =< Diff2 -> [A1, B1];
        true -> [A2, B2]
    end.

find_closest_pair(N) ->
    find_closest_pair_recursive(N, trunc(math:sqrt(N))).

find_closest_pair_recursive(N, I) when I > 0 ->
    if
        N rem I == 0 -> {I, N div I};
        true -> find_closest_pair_recursive(N, I - 1)
    end.