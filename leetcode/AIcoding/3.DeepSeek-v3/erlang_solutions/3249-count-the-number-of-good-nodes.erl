-spec good_nodes(Root :: #tree_node{} | null) -> integer().
good_nodes(null) -> 0;
good_nodes(Root) ->
    traverse(Root, Root#tree_node.val).

traverse(null, _Max) -> 0;
traverse(Node, Max) ->
    NewMax = max(Max, Node#tree_node.val),
    Count = if Node#tree_node.val >= Max -> 1; true -> 0 end,
    Count + traverse(Node#tree_node.left, NewMax) + traverse(Node#tree_node.right, NewMax).