-spec delete_nodes(Head :: #list_node{} | null, G :: [integer()]) -> #list_node{} | null.
delete_nodes(Head, G) ->
    GSet = sets:from_list(G),
    Dummy = #list_node{next = Head},
    Prev = Dummy,
    Current = Head,
    delete_nodes_helper(Prev, Current, GSet).

delete_nodes_helper(Prev, null, _GSet) ->
    Prev#list_node.next;
delete_nodes_helper(Prev, Current, GSet) ->
    case sets:is_element(Current#list_node.val, GSet) of
        true ->
            Prev#list_node.next = Current#list_node.next,
            delete_nodes_helper(Prev, Current#list_node.next, GSet);
        false ->
            delete_nodes_helper(Current, Current#list_node.next, GSet)
    end.