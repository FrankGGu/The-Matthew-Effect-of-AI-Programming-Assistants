-spec intersect(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
intersect(Nums1, Nums2) ->
    F = fun(X, Acc) ->
            case maps:get(X, Acc, 0) of
                Count when Count > 0 -> maps:put(X, Count - 1, Acc);
                _ -> Acc
            end
        end,
    Map = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums1),
    {_, Result} = lists:foldl(F, {Map, []}, Nums2),
    Result.