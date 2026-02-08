-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec convert_bst(Root :: #tree_node{} | null) -> #tree_node{} | null.
convert_bst(Root) ->
    {_, NewRoot} = traverse(Root, 0),
    NewRoot.

traverse(null, Sum) ->
    {Sum, null};
traverse(#tree_node{val = Val, right = Right, left = Left}, Sum) ->
    {NewSum, NewRight} = traverse(Right, Sum),
    CurrentSum = NewSum + Val,
    NewNode = #tree_node{val = CurrentSum, right = NewRight},
    {NewerSum, NewLeft} = traverse(Left, CurrentSum),
    {NewerSum, NewNode#tree_node{left = NewLeft}}.