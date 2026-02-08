-spec get_sum_absolute_differences(Nums :: [integer()]) -> [integer()].
get_sum_absolute_differences(Nums) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], Nums),
    lists:reverse(Prefix),
    Suffix = lists:foldr(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], Nums),
    lists:reverse(Suffix),
    lists:map(fun(I) ->
        X = lists:nth(I, Nums),
        LeftSum = X * (I - 1) - lists:nth(I, Prefix),
        RightSum = (lists:nth(I + 2, Suffix)) - X * (N - I),
        LeftSum + RightSum
    end, lists:seq(1, N)).