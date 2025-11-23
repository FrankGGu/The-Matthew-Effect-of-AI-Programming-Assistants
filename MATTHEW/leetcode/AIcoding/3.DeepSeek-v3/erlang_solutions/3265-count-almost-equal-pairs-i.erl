-spec count_almost_equal_pairs(Nums :: [integer()]) -> integer().
count_almost_equal_pairs(Nums) ->
    Count = 0,
    Len = length(Nums),
    lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    case abs(lists:nth(I, Nums) - lists:nth(J, Nums)) =< 1 of
                        true -> InnerAcc + 1;
                        false -> InnerAcc
                    end
                end,
                Acc,
                lists:seq(I + 1, Len)
            )
        end,
        Count,
        lists:seq(1, Len - 1)
    ).