-spec prune_tree(Root :: #tree_node{} | null) -> #tree_node{} | null.
prune_tree(null) -> null;
prune_tree(#tree_node{val = Val, left = Left, right = Right} = Node) ->
    NewLeft = prune_tree(Left),
    NewRight = prune_tree(Right),
    case Val =:= 0 andalso NewLeft =:= null andalso NewRight =:= null of
        true -> null;
        false -> Node#tree_node{left = NewLeft, right = NewRight}
    end.