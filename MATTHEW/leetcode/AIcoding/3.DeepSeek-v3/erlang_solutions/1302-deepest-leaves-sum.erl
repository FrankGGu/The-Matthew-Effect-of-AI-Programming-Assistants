-spec deepest_leaves_sum(Root :: #tree_node{} | null) -> integer().
deepest_leaves_sum(null) -> 0;
deepest_leaves_sum(Root) ->
    {Sum, _} = traverse(Root, 0, #{}),
    Sum.

traverse(null, _Depth, Map) -> {0, Map};
traverse(#tree_node{left = null, right = null, val = Val}, Depth, Map) ->
    case maps:get(Depth, Map, undefined) of
        undefined -> {Val, maps:put(Depth, Val, Map)};
        Sum -> {Sum + Val, maps:put(Depth, Sum + Val, Map)}
    end;
traverse(#tree_node{left = Left, right = Right, val = Val}, Depth, Map) ->
    {Sum1, Map1} = traverse(Left, Depth + 1, Map),
    {Sum2, Map2} = traverse(Right, Depth + 1, Map1),
    {Sum1 + Sum2, Map2}.