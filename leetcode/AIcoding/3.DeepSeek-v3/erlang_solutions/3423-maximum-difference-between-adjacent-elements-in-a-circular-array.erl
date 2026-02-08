-spec max_difference([integer()]) -> integer().
max_difference(Nums) ->
    N = length(Nums),
    MaxDiff = -1,
    lists:foldl(fun(I, Acc) ->
        J = (I + 1) rem N,
        Diff = lists:nth(J + 1, Nums) - lists:nth(I + 1, Nums),
        if
            Diff > 0 andalso Diff > Acc -> Diff;
            true -> Acc
        end
    end, MaxDiff, lists:seq(0, N - 1)).