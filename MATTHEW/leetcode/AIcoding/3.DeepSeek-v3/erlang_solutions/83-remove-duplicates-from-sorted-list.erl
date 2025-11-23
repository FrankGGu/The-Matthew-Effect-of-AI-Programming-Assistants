-spec delete_duplicates(Head :: #list_node{} | null) -> #list_node{} | null.
delete_duplicates(null) -> null;
delete_duplicates(#list_node{next = null} = Head) -> Head;
delete_duplicates(#list_node{val = Val, next = #list_node{val = Val} = Next}) ->
    delete_duplicates(#list_node{val = Val, next = Next#list_node.next});
delete_duplicates(#list_node{val = Val, next = Next}) ->
    #list_node{val = Val, next = delete_duplicates(Next)}.