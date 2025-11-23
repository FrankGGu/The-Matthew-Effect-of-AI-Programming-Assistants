-spec reverse_list(Head :: #list_node{} | null) -> #list_node{} | null.
reverse_list(Head) ->
    reverse_list(Head, null).

reverse_list(null, Prev) -> Prev;
reverse_list(#list_node{next = Next} = Node, Prev) ->
    NewNode = Node#list_node{next = Prev},
    reverse_list(Next, NewNode).