-spec sum_subarray_ranges(Nums :: [integer()]) -> integer().
sum_subarray_ranges(Nums) ->
    Sum = 0,
    Len = length(Nums),
    lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Subarray = lists:sublist(Nums, I, J - I + 1),
                    Max = lists:max(Subarray),
                    Min = lists:min(Subarray),
                    Acc2 + (Max - Min)
                end,
                Acc1,
                lists:seq(I, Len)
            )
        end,
        Sum,
        lists:seq(1, Len)
    ).