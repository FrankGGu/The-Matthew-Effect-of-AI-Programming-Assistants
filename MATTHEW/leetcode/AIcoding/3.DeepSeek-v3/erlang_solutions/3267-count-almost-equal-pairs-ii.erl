-spec count_almost_equal_pairs(Nums :: [integer()]) -> integer().
count_almost_equal_pairs(Nums) ->
    Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    lists:foldl(fun(X, Sum) ->
                    case maps:get(X + 1, Freq, 0) of
                        0 -> Sum + maps:get(X, Freq, 0) * (maps:get(X, Freq, 0) - 1) div 2;
                        C -> Sum + maps:get(X, Freq, 0) * C
                    end
                end, 0, maps:keys(Freq)).