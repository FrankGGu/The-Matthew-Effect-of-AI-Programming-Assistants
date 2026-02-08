-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec add_one_row(Root :: #treeNode{} | null, Val :: integer(), Depth :: integer()) -> #treeNode{} | null.
add_one_row(Root, Val, Depth) ->
    case Depth of
        1 ->
            #treeNode{val = Val, left = Root};
        _ ->
            add_one_row(Root, Val, Depth, 1)
    end.

-spec add_one_row(Node :: #treeNode{} | null, Val :: integer(), TargetDepth :: integer(), CurrentDepth :: integer()) -> #treeNode{} | null.
add_one_row(null, _, _, _) -> null;
add_one_row(Node, Val, TargetDepth, CurrentDepth) ->
    if
        CurrentDepth + 1 =:= TargetDepth ->
            NewLeft = #treeNode{val = Val, left = Node#treeNode.left},
            NewRight = #treeNode{val = Val, right = Node#treeNode.right},
            Node#treeNode{left = NewLeft, right = NewRight};
        true ->
            NewLeft = add_one_row(Node#treeNode.left, Val, TargetDepth, CurrentDepth + 1),
            NewRight = add_one_row(Node#treeNode.right, Val, TargetDepth, CurrentDepth + 1),
            Node#treeNode{left = NewLeft, right = NewRight}
    end.