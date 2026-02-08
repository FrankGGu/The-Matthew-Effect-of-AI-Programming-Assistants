-spec maximum_or(Nums :: [integer()], K :: integer()) -> integer().
maximum_or(Nums, K) ->
    MaxNum = lists:max(Nums),
    MaxBits = trunc(math:log2(MaxNum)) + 1,
    Prefix = lists:foldl(fun(N, Acc) -> Acc bor N end, 0, Nums),
    Suffix = lists:foldl(fun(N, Acc) -> Acc bor N end, 0, lists:reverse(Nums)),
    lists:foldl(
        fun(I, Acc) ->
            Shift = 1 bsl I,
            lists:foldl(
                fun(N, InnerAcc) ->
                    Current = (Prefix bor (N bsl (K * I))) bor (Suffix bxor N),
                    max(InnerAcc, Current)
                end,
                Acc,
                Nums
            )
        end,
        0,
        lists:seq(0, MaxBits + K)
    ).