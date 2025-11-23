-spec invert_tree(Root :: #tree_node{} | null) -> #tree_node{} | null.
invert_tree(null) -> null;
invert_tree(#tree_node{val = Val, left = Left, right = Right}) ->
    #tree_node{val = Val, left = invert_tree(Right), right = invert_tree(Left)}.