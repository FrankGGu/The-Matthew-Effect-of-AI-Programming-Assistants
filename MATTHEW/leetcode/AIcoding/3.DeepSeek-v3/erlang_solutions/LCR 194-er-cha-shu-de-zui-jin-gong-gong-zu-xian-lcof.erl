-spec lowest_common_ancestor(Root :: #tree_node{} | null, P :: #tree_node{}, Q :: #tree_node{}) -> #tree_node{} | null.
lowest_common_ancestor(Root, P, Q) ->
    case Root of
        null -> null;
        #tree_node{val = Val, left = Left, right = Right} ->
            if
                Val =:= P#tree_node.val; Val =:= Q#tree_node.val -> Root;
                true ->
                    LeftRes = lowest_common_ancestor(Left, P, Q),
                    RightRes = lowest_common_ancestor(Right, P, Q),
                    case {LeftRes, RightRes} of
                        {null, null} -> null;
                        {null, RightRes} -> RightRes;
                        {LeftRes, null} -> LeftRes;
                        {LeftRes, RightRes} -> Root
                    end
            end
    end.