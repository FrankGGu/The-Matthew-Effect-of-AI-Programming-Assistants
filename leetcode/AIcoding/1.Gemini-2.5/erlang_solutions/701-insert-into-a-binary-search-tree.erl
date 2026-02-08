-spec insertIntoBST(Root :: tree_node() | nil, Val :: integer()) -> tree_node() | nil.
insertIntoBST(nil, Val) ->
    {node, Val, nil, nil};
insertIntoBST({node, RootVal, Left, Right}, Val) when Val < RootVal ->
    {node, RootVal, insertIntoBST(Left, Val), Right};
insertIntoBST({node, RootVal, Left, Right}, Val) when Val > RootVal ->
    {node, RootVal, Left, insertIntoBST(Right, Val)}.