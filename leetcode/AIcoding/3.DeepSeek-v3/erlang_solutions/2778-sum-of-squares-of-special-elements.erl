-spec sum_of_squares(Nums :: [integer()]) -> integer().
sum_of_squares(Nums) ->
    Len = length(Nums),
    lists:foldl(
        fun(I, Acc) ->
            case Len rem I =:= 0 of
                true -> Acc + lists:nth(I, Nums) * lists:nth(I, Nums);
                false -> Acc
            end
        end,
        0,
        lists:seq(1, Len)
    ).