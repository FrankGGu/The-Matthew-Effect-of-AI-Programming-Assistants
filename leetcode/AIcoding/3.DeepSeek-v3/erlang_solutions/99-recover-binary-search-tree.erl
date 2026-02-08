-spec recover_tree(Root :: #tree_node{} | null) -> any().
recover_tree(Root) ->
    {First, Second, Prev} = traverse(Root, {null, null, null}),
    case {First, Second} of
        {null, null} -> ok;
        _ ->
            Temp = First#tree_node.val,
            First#tree_node.val = Second#tree_node.val,
            Second#tree_node.val = Temp
    end.

traverse(Node, {First, Second, Prev}) when Node =:= null ->
    {First, Second, Prev};
traverse(Node, {First, Second, Prev}) ->
    {NewFirst, NewSecond, NewPrev} = traverse(Node#tree_node.left, {First, Second, Prev}),
    UpdatedPrev = case NewPrev of
        null -> Node;
        _ ->
            if
                Node#tree_node.val < NewPrev#tree_node.val ->
                    case NewFirst of
                        null -> {NewPrev, Node, Node};
                        _ -> {NewFirst, Node, Node}
                    end;
                true -> {NewFirst, NewSecond, Node}
            end
    end,
    traverse(Node#tree_node.right, UpdatedPrev).