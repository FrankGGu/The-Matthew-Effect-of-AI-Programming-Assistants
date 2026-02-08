-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec search_bst(Root :: #treeNode{} | null, Val :: integer()) -> #treeNode{} | null.
search_bst(null, _Val) -> null;
search_bst(#treeNode{val = Val} = Node, Val) -> Node;
search_bst(#treeNode{val = V, left = Left}, Val) when Val < V -> search_bst(Left, Val);
search_bst(#treeNode{val = V, right = Right}, Val) when Val > V -> search_bst(Right, Val);
search_bst(_, _) -> null.