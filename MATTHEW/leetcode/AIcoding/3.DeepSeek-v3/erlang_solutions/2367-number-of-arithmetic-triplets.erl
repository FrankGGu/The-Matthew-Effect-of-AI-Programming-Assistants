-spec arithmetic_triplets(Nums :: [integer()], Diff :: integer()) -> integer().
arithmetic_triplets(Nums, Diff) ->
    Set = sets:from_list(Nums),
    lists:foldl(
        fun(Num, Acc) ->
            case sets:is_element(Num + Diff, Set) andalso sets:is_element(Num + 2 * Diff, Set) of
                true -> Acc + 1;
                false -> Acc
            end
        end,
        0,
        Nums
    ).