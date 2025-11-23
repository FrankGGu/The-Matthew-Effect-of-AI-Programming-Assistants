-spec lowest_common_ancestor(Root :: #tree_node{} | null, P :: #tree_node{}, Q :: #tree_node{}) -> #tree_node{}.
lowest_common_ancestor(Root, P, Q) ->
    case Root of
        null -> null;
        #tree_node{val = Val, left = Left, right = Right} ->
            PVal = P#tree_node.val,
            QVal = Q#tree_node.val,
            if
                Val > PVal andalso Val > QVal ->
                    lowest_common_ancestor(Left, P, Q);
                Val < PVal andalso Val < QVal ->
                    lowest_common_ancestor(Right, P, Q);
                true -> Root
            end
    end.