-spec intersection(arrays :: [[integer()]]) -> [integer()].
intersection(Arrays) ->
    case Arrays of
        [] -> [];
        [First | Rest] ->
            Sets = lists:map(fun(Array) -> sets:from_list(Array) end, Rest),
            Common = lists:foldl(fun(Set, Acc) -> sets:intersection(Acc, Set) end, sets:from_list(First), Sets),
            lists:sort(sets:to_list(Common))
    end.