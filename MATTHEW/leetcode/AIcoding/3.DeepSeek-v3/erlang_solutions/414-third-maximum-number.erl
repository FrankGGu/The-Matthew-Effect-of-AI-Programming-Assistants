-spec third_max(Nums :: [integer()]) -> integer().
third_max(Nums) ->
    Sorted = lists:usort(fun(A, B) -> A > B end, Nums),
    case length(Sorted) of
        Len when Len >= 3 -> lists:nth(3, Sorted);
        _ -> lists:nth(1, Sorted)
    end.