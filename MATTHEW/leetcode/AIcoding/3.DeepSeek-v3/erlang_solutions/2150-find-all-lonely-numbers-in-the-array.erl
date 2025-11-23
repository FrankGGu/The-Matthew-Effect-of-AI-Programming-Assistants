-spec find_lonely(Nums :: [integer()]) -> [integer()].
find_lonely(Nums) ->
    Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    lists:filter(fun(X) ->
        case maps:get(X, Freq, 0) of
            1 -> not (maps:is_key(X - 1, Freq) orelse maps:is_key(X + 1, Freq));
            _ -> false
        end
    end, Nums).