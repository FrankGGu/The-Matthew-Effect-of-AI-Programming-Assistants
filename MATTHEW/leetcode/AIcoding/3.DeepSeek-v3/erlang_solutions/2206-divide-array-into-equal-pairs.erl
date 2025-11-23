-spec divide_array(Nums :: [integer()]) -> boolean().
divide_array(Nums) ->
    Counts = lists:foldl(fun(N, Acc) ->
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Nums),
    lists:all(fun(_, V) -> V rem 2 == 0 end, maps:to_list(Counts)).