-record(tree_node, {val, left = nil, right = nil}).

pruneTree(nil) -> nil;
pruneTree(#tree_node{val = Val, left = Left, right = Right}) ->
    PrunedLeft = pruneTree(Left),
    PrunedRight = pruneTree(Right),

    if
        Val == 0 andalso PrunedLeft == nil andalso PrunedRight == nil ->
            nil;
        true ->
            #tree_node{val = Val, left = PrunedLeft, right = PrunedRight}
    end.