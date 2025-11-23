-spec sum_numbers(Root :: #tree_node{} | null) -> integer().
sum_numbers(null) -> 0;
sum_numbers(Root) -> 
    dfs(Root, 0).

dfs(null, _) -> 0;
dfs(#tree_node{val = Val, left = null, right = null}, PathSum) ->
    PathSum * 10 + Val;
dfs(#tree_node{val = Val, left = Left, right = Right}, PathSum) ->
    NewSum = PathSum * 10 + Val,
    dfs(Left, NewSum) + dfs(Right, NewSum).