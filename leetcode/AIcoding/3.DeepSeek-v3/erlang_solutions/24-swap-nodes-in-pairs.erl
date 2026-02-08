-spec swap_pairs(Head :: #list_node{} | null) -> #list_node{} | null.
swap_pairs(null) -> null;
swap_pairs(#list_node{next = null} = Node) -> Node;
swap_pairs(#list_node{val = Val1, next = #list_node{val = Val2, next = Next}}) ->
    #list_node{val = Val2, next = #list_node{val = Val1, next = swap_pairs(Next)}}.