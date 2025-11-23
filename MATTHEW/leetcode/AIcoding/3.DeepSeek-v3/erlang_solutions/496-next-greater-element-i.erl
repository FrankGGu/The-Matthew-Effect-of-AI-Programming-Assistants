-spec next_greater_element(Nums1 :: [integer()], Nums2 :: [integer()]) -> [integer()].
next_greater_element(Nums1, Nums2) ->
    Stack = [],
    Map = maps:new(),
    Processed = process_stack(Nums2, Stack, Map),
    [maps:get(Num, Processed, -1) || Num <- Nums1].

process_stack([], Stack, Map) -> Map;
process_stack([H | T], Stack, Map) ->
    case Stack of
        [] -> 
            process_stack(T, [H | Stack], Map);
        [Top | _] when H > Top ->
            NewMap = maps:put(Top, H, Map),
            NewStack = lists:delete(Top, Stack),
            process_stack([H | T], NewStack, NewMap);
        _ ->
            process_stack(T, [H | Stack], Map)
    end.