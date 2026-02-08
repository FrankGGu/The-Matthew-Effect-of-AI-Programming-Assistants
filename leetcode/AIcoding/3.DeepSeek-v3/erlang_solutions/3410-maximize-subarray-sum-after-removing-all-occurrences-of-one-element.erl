-spec maximum_sum(Nums :: [integer()]) -> integer().
maximum_sum(Nums) ->
    Sum = lists:sum(Nums),
    Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    Min = lists:min(Nums),
    Sum - Min * maps:get(Min, Freq).