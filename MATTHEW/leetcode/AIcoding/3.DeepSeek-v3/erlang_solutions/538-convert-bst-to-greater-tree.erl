-spec convert_bst(Root :: #tree_node{} | null) -> #tree_node{} | null.
convert_bst(Root) ->
    {NewRoot, _} = traverse(Root, 0),
    NewRoot.

traverse(null, Sum) ->
    {null, Sum};
traverse(Node, Sum) ->
    {Right, Sum1} = traverse(Node#tree_node.right, Sum),
    NewVal = Node#tree_node.val + Sum1,
    {Left, Sum2} = traverse(Node#tree_node.left, NewVal),
    {#tree_node{val = NewVal, left = Left, right = Right}, Sum2}.