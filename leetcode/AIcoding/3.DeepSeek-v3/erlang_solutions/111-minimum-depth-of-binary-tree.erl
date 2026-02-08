-spec min_depth(Root :: #tree_node{} | null) -> integer().
min_depth(null) -> 0;
min_depth(Root) ->
    case {Root#tree_node.left, Root#tree_node.right} of
        {null, null} -> 1;
        {null, Right} -> 1 + min_depth(Right);
        {Left, null} -> 1 + min_depth(Left);
        {Left, Right} -> 1 + min(min_depth(Left), min_depth(Right))
    end.