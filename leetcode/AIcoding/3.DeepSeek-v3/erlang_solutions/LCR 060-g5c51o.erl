-spec top_k_frequent(Nums :: [integer()], K :: integer()) -> [integer()].
top_k_frequent(Nums, K) ->
    FreqMap = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(FreqMap)),
    TopK = lists:sublist(Sorted, K),
    [N || {N, _} <- TopK].