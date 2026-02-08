-spec count_house_placements(N :: integer()) -> integer().
count_house_placements(N) ->
    Mod = 1000000007,
    DP = lists:foldl(fun(_, [A, B]) -> [(A + B) rem Mod, A] end, [1, 1], lists:seq(1, N)),
    [A, _] = DP,
    (A * A) rem Mod.