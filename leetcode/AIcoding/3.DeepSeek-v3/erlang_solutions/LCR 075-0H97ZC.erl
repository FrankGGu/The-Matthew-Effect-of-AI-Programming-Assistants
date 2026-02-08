-spec relative_sort_array(Arr1 :: [integer()], Arr2 :: [integer()]) -> [integer()].
relative_sort_array(Arr1, Arr2) ->
    Map = lists:foldl(fun(X, Acc) -> maps:put(X, maps:get(X, Acc, 0) + 1, Acc) end, #{}, Arr1),
    {InArr2, NotInArr2} = lists:partition(fun(X) -> maps:is_key(X, Map) end, Arr2),
    SortedNotInArr2 = lists:sort([X || X <- Arr1, not lists:member(X, Arr2)]),
    lists:flatten([lists:duplicate(maps:get(X, Map), X) || X <- InArr2]) ++ SortedNotInArr2.