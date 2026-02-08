-spec third_max(Nums :: [integer()]) -> integer().
third_max(Nums) ->
    SortedUnique = lists:reverse(lists:usort(Nums)),
    case length(SortedUnique) of
        Len when Len >= 3 ->
            lists:nth(3, SortedUnique);
        _ ->
            lists:nth(1, SortedUnique)
    end.