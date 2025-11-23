-spec find_lhs(Nums :: [integer()]) -> integer().
find_lhs(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
        maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Nums),
    maps:fold(fun(K, V, Acc) ->
        case maps:is_key(K + 1, FreqMap) of
            true -> max(Acc, V + maps:get(K + 1, FreqMap));
            false -> Acc
        end
    end, 0, FreqMap).