-spec top_k_frequent(Nums :: [integer()], K :: integer()) -> [integer()].
top_k_frequent(Nums, K) ->
    FreqMap = lists:foldl(fun(Num, Acc) -> 
                              maps:update_with(Num, fun(V) -> V + 1 end, 1, Acc) 
                          end, #{}, Nums),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, maps:to_list(FreqMap)),
    TopK = lists:sublist(Sorted, K),
    [Num || {Num, _} <- TopK].