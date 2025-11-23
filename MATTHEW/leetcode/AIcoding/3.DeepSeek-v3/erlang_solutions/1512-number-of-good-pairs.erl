-spec num_identical_pairs(Nums :: [integer()]) -> integer().
num_identical_pairs(Nums) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    lists:foldl(fun(_, Sum) -> Sum end, 0, maps:fold(fun(_, V, Acc) -> Acc + V * (V - 1) div 2 end, 0, Counts)).