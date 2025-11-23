-spec insert_into_bst(Root :: #tree_node{} | null, Val :: integer()) -> #tree_node{}.
insert_into_bst(null, Val) ->
    #tree_node{val = Val, left = null, right = null};
insert_into_bst(Root = #tree_node{val = V, left = Left, right = Right}, Val) when Val < V ->
    Root#tree_node{left = insert_into_bst(Left, Val)};
insert_into_bst(Root = #tree_node{val = V, right = Right}, Val) ->
    Root#tree_node{right = insert_into_bst(Right, Val)}.