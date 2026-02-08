-spec remove_leaf_nodes(Root :: #tree_node{} | null, Target :: integer()) -> #tree_node{} | null.
remove_leaf_nodes(null, _Target) -> null;
remove_leaf_nodes(#tree_node{val = Val, left = Left, right = Right} = Node, Target) ->
    NewLeft = remove_leaf_nodes(Left, Target),
    NewRight = remove_leaf_nodes(Right, Target),
    case {NewLeft, NewRight, Val} of
        {null, null, Target} -> null;
        _ -> #tree_node{val = Val, left = NewLeft, right = NewRight}
    end.