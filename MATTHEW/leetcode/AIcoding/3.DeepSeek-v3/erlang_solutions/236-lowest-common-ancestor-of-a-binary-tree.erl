-spec lowest_common_ancestor(Root :: #tree_node{} | null, P :: #tree_node{} | null, Q :: #tree_node{} | null) -> #tree_node{} | null.
lowest_common_ancestor(Root, P, Q) ->
    case Root of
        null -> null;
        _ ->
            case Root of
                P -> Root;
                Q -> Root;
                _ ->
                    Left = lowest_common_ancestor(Root#tree_node.left, P, Q),
                    Right = lowest_common_ancestor(Root#tree_node.right, P, Q),
                    case {Left, Right} of
                        {null, null} -> null;
                        {null, Right} -> Right;
                        {Left, null} -> Left;
                        {Left, Right} -> Root
                    end
            end
    end.