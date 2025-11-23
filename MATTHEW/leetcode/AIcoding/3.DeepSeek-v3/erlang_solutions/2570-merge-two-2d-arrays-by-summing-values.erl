-spec merge_arrays(Nums1 :: [[integer()]], Nums2 :: [[integer()]]) -> [[integer()]].
merge_arrays(Nums1, Nums2) ->
    Map1 = maps:from_list([{Id, Val} || [Id, Val] <- Nums1]),
    Map2 = maps:from_list([{Id, Val} || [Id, Val] <- Nums2]),
    Merged = maps:merge(fun(_, V1, V2) -> V1 + V2 end, Map1, Map2),
    Sorted = lists:sort(maps:to_list(Merged)),
    [[Id, Val] || {Id, Val} <- Sorted].