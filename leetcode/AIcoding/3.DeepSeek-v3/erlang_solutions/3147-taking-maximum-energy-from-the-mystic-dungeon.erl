-spec maximum_energy(Energy :: [integer()], K :: integer()) -> integer().
maximum_energy(Energy, K) ->
    N = length(Energy),
    DP = lists:duplicate(N, 0),
    DP1 = lists:zipwith(fun(I, E) -> E end, lists:seq(1, N), Energy),
    MaxEnergy = lists:foldl(fun(I, Acc) ->
        Prev = if I - K >= 1 -> lists:nth(I - K, DP); true -> 0 end,
        Current = lists:nth(I, DP1) + Prev,
        NewDP = lists:sublist(DP, I - 1) ++ [Current] ++ lists:nthtail(I, DP),
        {NewDP, max(Acc, Current)}
    end, {DP1, hd(Energy)}, lists:seq(K + 1, N)),
    element(2, MaxEnergy).