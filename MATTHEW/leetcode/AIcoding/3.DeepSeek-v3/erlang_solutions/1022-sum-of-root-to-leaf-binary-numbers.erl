-spec sum_root_to_leaf(Root :: #tree_node{} | null) -> integer().
sum_root_to_leaf(Root) ->
    dfs(Root, 0).

dfs(null, _) -> 0;
dfs(#tree_node{val = Val, left = null, right = null}, Path) ->
    (Path bsl 1) + Val;
dfs(#tree_node{val = Val, left = Left, right = Right}, Path) ->
    NewPath = (Path bsl 1) + Val,
    dfs(Left, NewPath) + dfs(Right, NewPath).