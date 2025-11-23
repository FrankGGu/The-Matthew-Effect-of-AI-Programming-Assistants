-spec subtree_with_all_deepest(Root :: #tree_node{} | null) -> #tree_node{} | null.
subtree_with_all_deepest(Root) ->
    case Root of
        null -> null;
        _ ->
            {Subtree, _} = helper(Root),
            Subtree
    end.

helper(Node) ->
    case Node of
        null -> {null, 0};
        _ ->
            {Left, LDepth} = helper(Node#tree_node.left),
            {Right, RDepth} = helper(Node#tree_node.right),
            if
                LDepth > RDepth -> {Left, LDepth + 1};
                RDepth > LDepth -> {Right, RDepth + 1};
                true -> {Node, LDepth + 1}
            end
    end.