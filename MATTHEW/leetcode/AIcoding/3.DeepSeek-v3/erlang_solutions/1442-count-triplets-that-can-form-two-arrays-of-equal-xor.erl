-spec count_triplets(Arr :: [integer()]) -> integer().
count_triplets(Arr) ->
    N = length(Arr),
    Prefix = lists:foldl(fun(X, Acc) -> [X bxor hd(Acc) | Acc] end, [0], Arr),
    PrefixRev = lists:reverse(Prefix),
    Count = 0,
    {Result, _} = lists:foldl(
        fun(I, {Cnt, _}) ->
            lists:foldl(
                fun(K, {C, _}) ->
                    case lists:nth(I + 1, PrefixRev) bxor lists:nth(K + 1, PrefixRev) of
                        0 -> {C + (K - I), C + (K - I)};
                        _ -> {C, C}
                    end
                end,
                {Cnt, 0},
                lists:seq(I + 1, N)
            )
        end,
        {Count, 0},
        lists:seq(1, N - 1)
    ),
    Result.