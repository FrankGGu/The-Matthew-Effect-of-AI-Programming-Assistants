-spec min_camera_cover(Root :: #tree_node{} | null) -> integer().
min_camera_cover(Root) ->
    {Ans, _, _} = dfs(Root),
    Ans.

dfs(null) ->
    {0, 2, 0};
dfs(Node) ->
    Left = Node#tree_node.left,
    Right = Node#tree_node.right,
    {L0, L1, L2} = dfs(Left),
    {R0, R1, R2} = dfs(Right),
    MinLR0 = min(L1 + R1, min(L1 + R2, L2 + R1)),
    MinLR1 = min(L2 + R2, min(L0 + R2, L2 + R0)),
    MinLR2 = L0 + R0,
    {MinLR0, MinLR1, MinLR2}.