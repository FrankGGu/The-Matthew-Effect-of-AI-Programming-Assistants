-spec delete_node(Root :: #tree_node{} | null, Key :: integer()) -> #tree_node{} | null.
delete_node(null, _Key) -> null;
delete_node(#tree_node{val = Val, left = Left, right = Right} = Node, Key) ->
    if
        Key < Val ->
            Node#tree_node{left = delete_node(Left, Key)};
        Key > Val ->
            Node#tree_node{right = delete_node(Right, Key)};
        true ->
            case {Left, Right} of
                {null, null} -> null;
                {null, Right} -> Right;
                {Left, null} -> Left;
                {Left, Right} ->
                    MinNode = find_min(Right),
                    Node#tree_node{val = MinNode#tree_node.val, right = delete_node(Right, MinNode#tree_node.val)}
            end
    end.

find_min(#tree_node{left = null} = Node) -> Node;
find_min(#tree_node{left = Left}) -> find_min(Left).