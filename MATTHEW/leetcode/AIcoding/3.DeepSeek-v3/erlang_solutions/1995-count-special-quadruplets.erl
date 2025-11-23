-spec count_quadruplets(Nums :: [integer()]) -> integer().
count_quadruplets(Nums) ->
    N = length(Nums),
    Count = 0,
    count_quadruplets(Nums, N, Count).

count_quadruplets(Nums, N, Count) ->
    case N >= 4 of
        false -> Count;
        true ->
            NewCount = lists:foldl(fun(I, Acc) ->
                lists:foldl(fun(J, Acc1) ->
                    lists:foldl(fun(K, Acc2) ->
                        lists:foldl(fun(L, Acc3) ->
                            case (I < J) and (J < K) and (K < L) and (lists:nth(I, Nums) + lists:nth(J, Nums) + lists:nth(K, Nums) == lists:nth(L, Nums)) of
                                true -> Acc3 + 1;
                                false -> Acc3
                            end
                        end, Acc2, lists:seq(K + 1, N))
                    end, Acc1, lists:seq(J + 1, N - 1))
                end, Acc, lists:seq(I + 1, N - 2))
            end, Count, lists:seq(1, N - 3)),
            NewCount
    end.