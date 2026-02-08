-spec search_bst(Root :: nil | tree_node(), Val :: integer()) -> nil | tree_node().
search_bst(nil, _Val) ->
    nil;
search_bst(#{val := Val, left := _Left, right := _Right} = Node, Val) ->
    Node;
search_bst(#{val := NodeVal, left := Left, right := _Right}, Val) when Val < NodeVal ->
    search_bst(Left, Val);
search_bst(#{val := NodeVal, left := _Left, right := Right}, Val) when Val > NodeVal ->
    search_bst(Right, Val).