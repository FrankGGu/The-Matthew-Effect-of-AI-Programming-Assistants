-record(treeNode, {val = 0 :: integer(),
                  left = null  :: 'null' | #treeNode{},
                  right = null :: 'null' | #treeNode{}}).

-spec is_cousins(Root :: #treeNode{} | null, X :: integer(), Y :: integer()) -> boolean().
is_cousins(Root, X, Y) ->
    case Root of
        null -> false;
        _ ->
            {DepthX, ParentX} = find_node(Root, X, 0, null),
            {DepthY, ParentY} = find_node(Root, Y, 0, null),
            (DepthX =:= DepthY) and (ParentX =/= ParentY)
    end.

find_node(null, _, _, _) -> {0, null};
find_node(Node, Val, Depth, Parent) ->
    if
        Node#treeNode.val =:= Val -> {Depth, Parent};
        true ->
            Left = find_node(Node#treeNode.left, Val, Depth + 1, Node),
            case Left of
                {0, null} -> find_node(Node#treeNode.right, Val, Depth + 1, Node);
                _ -> Left
            end
    end.