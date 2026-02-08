-spec subarrays_with_and(Nums :: [integer()], K :: integer()) -> integer().
subarrays_with_and(Nums, K) ->
    Count = 0,
    Len = length(Nums),
    lists:foldl(
        fun(I, Acc) ->
            Current = 0,
            lists:foldl(
                fun(J, {Cnt, Curr}) ->
                    NewCurr = Curr band lists:nth(J + 1, Nums),
                    if
                        NewCurr == K -> {Cnt + 1, NewCurr};
                        true -> {Cnt, NewCurr}
                    end
                end,
                {Acc, Current},
                lists:seq(I, Len - 1)
            )
        end,
        Count,
        lists:seq(0, Len - 1)
    ).