-record(treeNode, {val = 0 :: integer(),
                  left = null  :: 'null' | #treeNode{},
                  right = null :: 'null' | #treeNode{}}).

-spec expand_binary_tree(:: #treeNode{} | null) -> #treeNode{} | null.
expand_binary_tree(null) -> null;
expand_binary_tree(#treeNode{val = Val, left = Left, right = Right}) ->
    NewLeft = case Left of
        null -> null;
        _ -> #treeNode{val = -1, left = expand_binary_tree(Left), right = null}
    end,
    NewRight = case Right of
        null -> null;
        _ -> #treeNode{val = -1, left = null, right = expand_binary_tree(Right)}
    end,
    #treeNode{val = Val, left = NewLeft, right = NewRight}.