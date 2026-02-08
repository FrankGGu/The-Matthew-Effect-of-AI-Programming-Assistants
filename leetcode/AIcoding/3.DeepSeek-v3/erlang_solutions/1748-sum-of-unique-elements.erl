-spec sum_of_unique(Nums :: [integer()]) -> integer().
sum_of_unique(Nums) ->
    Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    lists:foldl(fun({K, V}, Sum) -> if V == 1 -> Sum + K; true -> Sum end end, 0, maps:to_list(Freq)).