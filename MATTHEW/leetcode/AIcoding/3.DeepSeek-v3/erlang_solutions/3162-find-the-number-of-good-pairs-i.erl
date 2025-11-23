-spec num_identical_pairs(Nums :: [integer()]) -> integer().
num_identical_pairs(Nums) ->
    Counts = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                         end, #{}, Nums),
    lists:foldl(fun(V, Sum) -> Sum + V * (V - 1) div 2 end, 0, maps:values(Counts)).