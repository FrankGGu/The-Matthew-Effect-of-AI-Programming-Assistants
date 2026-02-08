-spec max_value(TreeNode :: #tree_node{} | null, K :: integer()) -> integer().
max_value(null, _K) -> 0;
max_value(Root, K) ->
    {WithRoot, WithoutRoot} = dfs(Root, K),
    max(WithRoot, WithoutRoot).

dfs(null, _K) -> {0, 0};
dfs(Node, K) ->
    {LeftWith, LeftWithout} = dfs(Node#tree_node.left, K),
    {RightWith, RightWithout} = dfs(Node#tree_node.right, K),
    MaxWithout = LeftWith + RightWith,
    MaxWith = Node#tree_node.val + LeftWithout + RightWithout,
    if
        K > 0 ->
            {max(MaxWith, MaxWithout), MaxWithout};
        true ->
            {MaxWithout, MaxWithout}
    end.