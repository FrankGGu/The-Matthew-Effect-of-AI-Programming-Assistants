-spec prune_tree(Root :: #{} | null) -> #{} | null.
prune_tree(null) -> null;
prune_tree(#{val := Val, left := Left, right := Right} = Node) ->
    NewLeft = prune_tree(Left),
    NewRight = prune_tree(Right),
    case Val == 0 andalso NewLeft == null andalso NewRight == null of
        true -> null;
        false -> Node#{left := NewLeft, right := NewRight}
    end.