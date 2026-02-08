-spec inorder_successor(Root :: #tree_node{} | null, P :: #tree_node{}) -> #tree_node{} | null.
inorder_successor(Root, P) ->
    case Root of
        null -> null;
        #tree_node{val = Val, left = Left, right = Right} ->
            case P#tree_node.val >= Val of
                true -> inorder_successor(Right, P);
                false ->
                    case inorder_successor(Left, P) of
                        null -> Root;
                        Successor -> Successor
                    end
            end
    end.