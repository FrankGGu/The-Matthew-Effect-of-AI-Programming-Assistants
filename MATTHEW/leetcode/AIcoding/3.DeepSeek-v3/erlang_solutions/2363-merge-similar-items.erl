-spec merge_similar_items(Items1 :: [[integer()]], Items2 :: [[integer()]]) -> [[integer()]].
merge_similar_items(Items1, Items2) ->
    Map1 = lists:foldl(fun([V, W], Acc) -> maps:put(V, W, Acc) end, #{}, Items1),
    Map2 = lists:foldl(fun([V, W], Acc) -> maps:update_with(V, fun(Old) -> Old + W end, W, Acc) end, Map1, Items2),
    Sorted = lists:sort(maps:to_list(Map2)),
    [[V, W] || {V, W} <- Sorted].