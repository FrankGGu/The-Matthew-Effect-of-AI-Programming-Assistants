-spec find_pairs(Nums :: [integer()], K :: integer()) -> integer().
find_pairs(Nums, K) ->
    Count = maps:new(),
    Pairs = sets:new(),
    lists:foreach(fun(Num) ->
        case maps:get(Num - K, Count, undefined) of
            undefined -> ok;
            _ -> sets:add_element({Num - K, Num}, Pairs)
        end,
        case maps:get(Num + K, Count, undefined) of
            undefined -> ok;
            _ -> sets:add_element({Num, Num + K}, Pairs)
        end,
        Count1 = maps:update_with(Num, fun(V) -> V + 1 end, 1, Count),
        Count = Count1
    end, Nums),
    sets:size(Pairs).