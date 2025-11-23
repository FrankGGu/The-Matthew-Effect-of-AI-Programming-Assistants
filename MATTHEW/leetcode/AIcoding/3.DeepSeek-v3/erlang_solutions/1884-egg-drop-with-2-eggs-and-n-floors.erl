-spec two_egg_drop(N :: integer()) -> integer().
two_egg_drop(N) ->
    two_egg_drop(N, 1, 1).

two_egg_drop(N, K, M) when K >= N ->
    M;
two_egg_drop(N, K, M) ->
    two_egg_drop(N, K + M + 1, M + 1).