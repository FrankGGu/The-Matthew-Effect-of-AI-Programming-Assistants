-spec count_triplets(List :: [integer()]) -> integer().
count_triplets(List) ->
    N = length(List),
    Triplets = lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    lists:foldl(
                        fun(K, Acc3) ->
                            case (List !! I) bxor (List !! J) bxor (List !! K) of
                                0 -> Acc3 + 1;
                                _ -> Acc3
                            end
                        end,
                        Acc2,
                        lists:seq(J + 1, N - 1)
                    )
                end,
                Acc1,
                lists:seq(I + 1, N - 1)
        end,
        0,
        lists:seq(0, N - 1)
    ),
    Triplets.