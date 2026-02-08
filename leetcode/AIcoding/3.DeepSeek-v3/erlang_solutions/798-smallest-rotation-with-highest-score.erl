-spec best_rotation(Nums :: [integer()]) -> integer().
best_rotation(Nums) ->
    N = length(Nums),
    Diffs = lists:duplicate(N + 1, 0),
    lists:foldl(fun(I, {DiffsAcc, K, Max, Res}) ->
        Num = lists:nth(I + 1, Nums),
        L = (I - Num + 1 + N) rem N,
        R = (I + 1) rem N,
        NewDiffs = update_diffs(DiffsAcc, L, R),
        Score = case K of 0 -> 0; _ -> lists:nth(K, NewDiffs) + lists:nth(K - 1, NewDiffs) end,
        if Score > Max -> {NewDiffs, (K + 1) rem N, Score, K};
           true -> {NewDiffs, (K + 1) rem N, Max, Res}
        end
    end, {Diffs, 0, 0, 0}, lists:seq(0, N - 1)),
    element(4, {Diffs, 0, 0, 0}).

update_diffs(Diffs, L, R) ->
    NewDiffs = setelement(L + 1, Diffs, element(L + 1, Diffs) + 1),
    if R + 1 =< length(Diffs) -> setelement(R + 1, NewDiffs, element(R + 1, NewDiffs) - 1);
       true -> NewDiffs
    end.