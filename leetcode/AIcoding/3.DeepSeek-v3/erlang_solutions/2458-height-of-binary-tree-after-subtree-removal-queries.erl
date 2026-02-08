-spec tree_queries(Root :: #tree_node{} | null, Queries :: [integer()]) -> [integer()].
tree_queries(Root, Queries) ->
    case Root of
        null -> [];
        _ ->
            DepthMap = maps:new(),
            {DepthMap1, _} = compute_depths(Root, DepthMap, 0),
            MaxDepthMap = maps:new(),
            MaxDepthMap1 = compute_max_depths(Root, DepthMap1, MaxDepthMap, 0),
            process_queries(Root, Queries, DepthMap1, MaxDepthMap1, [])
    end.

compute_depths(null, DepthMap, _) -> {DepthMap, -1};
compute_depths(#tree_node{val = Val, left = Left, right = Right}, DepthMap, ParentDepth) ->
    {DepthMap1, LeftDepth} = compute_depths(Left, DepthMap, ParentDepth + 1),
    {DepthMap2, RightDepth} = compute_depths(Right, DepthMap1, ParentDepth + 1),
    CurrentDepth = max(LeftDepth, RightDepth) + 1,
    DepthMap3 = maps:put(Val, CurrentDepth, DepthMap2),
    {DepthMap3, CurrentDepth}.

compute_max_depths(null, _DepthMap, MaxDepthMap, _ParentMax) -> MaxDepthMap;
compute_max_depths(#tree_node{val = Val, left = Left, right = Right}, DepthMap, MaxDepthMap, ParentMax) ->
    LeftVal = case Left of null -> -1; #tree_node{val = V} -> V end,
    RightVal = case Right of null -> -1; #tree_node{val = V} -> V end,
    LeftDepth = case Left of null -> -1; _ -> maps:get(LeftVal, DepthMap) end,
    RightDepth = case Right of null -> -1; _ -> maps:get(RightVal, DepthMap) end,
    CurrentMax = ParentMax + 1,
    MaxDepthMap1 = maps:put(Val, CurrentMax, MaxDepthMap),
    MaxDepthMap2 = compute_max_depths(Left, DepthMap, MaxDepthMap1, max(CurrentMax, RightDepth + 1)),
    compute_max_depths(Right, DepthMap, MaxDepthMap2, max(CurrentMax, LeftDepth + 1)).

process_queries(_Root, [], _DepthMap, _MaxDepthMap, Acc) -> lists:reverse(Acc);
process_queries(Root, [Query | Rest], DepthMap, MaxDepthMap, Acc) ->
    Depth = maps:get(Query, DepthMap),
    MaxDepth = maps:get(Query, MaxDepthMap),
    process_queries(Root, Rest, DepthMap, MaxDepthMap, [max(Depth, MaxDepth) | Acc]).