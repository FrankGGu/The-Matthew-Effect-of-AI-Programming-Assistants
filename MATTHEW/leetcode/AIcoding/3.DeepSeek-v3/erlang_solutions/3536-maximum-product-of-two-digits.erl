-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    case Len >= 2 of
        true ->
            Max1 = lists:nth(Len, Sorted),
            Max2 = lists:nth(Len - 1, Sorted),
            Min1 = lists:nth(1, Sorted),
            Min2 = lists:nth(2, Sorted),
            max(Max1 * Max2, Min1 * Min2);
        false ->
            0
    end.