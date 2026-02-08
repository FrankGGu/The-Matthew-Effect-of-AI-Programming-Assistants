-spec min_difference(Nums :: [integer()]) -> integer().
min_difference(Nums) ->
    case length(Nums) =< 4 of
        true -> 0;
        false ->
            Sorted = lists:sort(Nums),
            Len = length(Sorted),
            lists:min([
                lists:nth(Len - 3, Sorted) - lists:nth(1, Sorted),
                lists:nth(Len - 2, Sorted) - lists:nth(2, Sorted),
                lists:nth(Len - 1, Sorted) - lists:nth(3, Sorted),
                lists:nth(Len, Sorted) - lists:nth(4, Sorted)
            ])
    end.