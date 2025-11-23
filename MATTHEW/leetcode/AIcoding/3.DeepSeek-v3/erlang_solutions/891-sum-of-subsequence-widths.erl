-spec sum_subseq_widths(Nums :: [integer()]) -> integer().
sum_subseq_widths(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Mod = 1000000007,
    Power = lists:foldl(fun(_, Acc) -> [2 * (hd(Acc)) rem Mod | Acc] end, [1], lists:seq(1, N)),
    lists:foldl(fun(I, {Res, Pow}) ->
                    X = lists:nth(I, Sorted),
                    Y = lists:nth(N - I + 1, Sorted),
                    { (Res + (Y - X) * Pow) rem Mod, (Pow * 2) rem Mod }
                end, {0, 1}, lists:seq(1, N)) rem Mod.