-spec max_ancestor_diff(Root :: #tree_node{} | null) -> integer().
max_ancestor_diff(Root) ->
    case Root of
        null -> 0;
        _ -> dfs(Root, Root#tree_node.val, Root#tree_node.val)
    end.

dfs(null, _Min, _Max) -> 0;
dfs(Node, Min, Max) ->
    CurrentMin = min(Min, Node#tree_node.val),
    CurrentMax = max(Max, Node#tree_node.val),
    CurrentDiff = CurrentMax - CurrentMin,
    LeftDiff = dfs(Node#tree_node.left, CurrentMin, CurrentMax),
    RightDiff = dfs(Node#tree_node.right, CurrentMin, CurrentMax),
    max(CurrentDiff, max(LeftDiff, RightDiff)).