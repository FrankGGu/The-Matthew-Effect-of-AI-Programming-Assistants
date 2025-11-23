-spec numMusicPlaylists(N :: integer(), L :: integer(), K :: integer()) -> integer().
numMusicPlaylists(N, L, K) ->
    Mod = 1000000007,
    DP = lists:duplicate(L + 1, lists:duplicate(N + 1, 0)),
    DP1 = setelement(1, DP, setelement(1, element(1, DP), 1)),
    DP2 = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            Prev1 = element(I, element(J, AccJ)),
            Prev2 = if J > K -> element(I, element(J - K, AccJ)) else 0 end,
            Val = (Prev1 * max(J - K, 0) + Prev2 * (N - J + 1)) rem Mod,
            setelement(J, element(I, AccJ), Val)
        end, AccI, lists:seq(1, N))
    end, DP1, lists:seq(2, L)),
    element(N, element(L, DP2)).