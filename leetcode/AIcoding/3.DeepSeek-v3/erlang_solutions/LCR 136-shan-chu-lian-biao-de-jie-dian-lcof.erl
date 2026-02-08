-spec delete_node(Head :: #list_node{} | null, Val :: integer()) -> #list_node{} | null.
delete_node(null, _Val) -> null;
delete_node(Head, Val) when Head#list_node.val =:= Val -> Head#list_node.next;
delete_node(Head, Val) ->
    Head#list_node{next = delete_node(Head#list_node.next, Val)}.