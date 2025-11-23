-spec good_nodes(Root :: #tree_node{} | null) -> integer().
good_nodes(Root) ->
    case Root of
        null -> 0;
        _ -> traverse(Root, Root#tree_node.val)
    end.

traverse(Node, Max) when Node =:= null ->
    0;
traverse(Node, Max) ->
    CurrentMax = max(Max, Node#tree_node.val),
    Count = if Node#tree_node.val >= Max -> 1; true -> 0 end,
    Count + traverse(Node#tree_node.left, CurrentMax) + traverse(Node#tree_node.right, CurrentMax).