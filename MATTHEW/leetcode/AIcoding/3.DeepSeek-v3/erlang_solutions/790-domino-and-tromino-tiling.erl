-spec num_tilings(N :: integer()) -> integer().
num_tilings(N) ->
    Mod = 1000000007,
    case N of
        1 -> 1;
        2 -> 2;
        3 -> 5;
        _ ->
            DP = lists:duplicate(N + 1, 0),
            DP1 = setelement(1, DP, 1),
            DP2 = setelement(2, DP1, 2),
            DP3 = setelement(3, DP2, 5),
            num_tilings(N, 4, DP3, Mod)
    end.

num_tilings(N, I, DP, Mod) when I =< N ->
    Prev1 = element(I - 1, DP),
    Prev2 = element(I - 2, DP),
    Prev3 = element(I - 3, DP),
    Val = (2 * Prev1 + Prev3) rem Mod,
    NewDP = setelement(I, DP, Val),
    num_tilings(N, I + 1, NewDP, Mod);
num_tilings(N, _, DP, _) ->
    element(N, DP).