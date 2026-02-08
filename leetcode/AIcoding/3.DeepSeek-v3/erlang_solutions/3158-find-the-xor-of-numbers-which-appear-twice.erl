-spec find_duplicate_xor(Nums :: [integer()]) -> integer().
find_duplicate_xor(Nums) ->
    Counts = lists:foldl(fun(N, Acc) -> 
                            maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Nums),
    lists:foldl(fun({K, V}, Acc) -> 
                    if V == 2 -> Acc bxor K;
                       true -> Acc
                    end
                 end, 0, maps:to_list(Counts)).