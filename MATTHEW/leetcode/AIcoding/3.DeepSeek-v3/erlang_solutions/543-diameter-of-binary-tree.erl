-spec diameter_of_binary_tree(Root :: #tree_node{} | null) -> integer().
diameter_of_binary_tree(Root) ->
    {MaxDiameter, _} = helper(Root),
    MaxDiameter.

helper(null) ->
    {0, 0};
helper(#tree_node{left = Left, right = Right}) ->
    {LeftDiameter, LeftDepth} = helper(Left),
    {RightDiameter, RightDepth} = helper(Right),
    CurrentDiameter = LeftDepth + RightDepth,
    MaxDiameter = max(max(LeftDiameter, RightDiameter), CurrentDiameter),
    MaxDepth = max(LeftDepth, RightDepth) + 1,
    {MaxDiameter, MaxDepth}.