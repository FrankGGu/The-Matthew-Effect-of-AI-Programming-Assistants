-spec lca_deepest_leaves(Root :: #tree_node{} | null) -> #tree_node{} | null.
lca_deepest_leaves(Root) ->
    case Root of
        null -> null;
        _ ->
            {LCA, _} = helper(Root, 0),
            LCA
    end.

helper(Node, Depth) ->
    case Node of
        null -> {null, Depth};
        _ ->
            {LeftLCA, LeftDepth} = helper(Node#tree_node.left, Depth + 1),
            {RightLCA, RightDepth} = helper(Node#tree_node.right, Depth + 1),
            if
                LeftDepth > RightDepth -> {LeftLCA, LeftDepth};
                RightDepth > LeftDepth -> {RightLCA, RightDepth};
                true -> {Node, LeftDepth}
            end
    end.