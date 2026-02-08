-spec sum_imbalance_numbers(Nums :: [integer()]) -> integer().
sum_imbalance_numbers(Nums) ->
    N = length(Nums),
    Sum = 0,
    lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Subarray = lists:sublist(Nums, I, J - I + 1),
                    Sorted = lists:sort(Subarray),
                    Imbalance = lists:foldl(
                        fun(K, Acc3) ->
                            case K > 1 andalso (lists:nth(K, Sorted) - lists:nth(K - 1, Sorted) > 1) of
                                true -> Acc3 + 1;
                                false -> Acc3
                            end
                        end,
                        0,
                        lists:seq(2, length(Sorted))
                    ),
                    Acc2 + Imbalance
                end,
                Acc1,
                lists:seq(I, N))
        end,
        Sum,
        lists:seq(1, N)).