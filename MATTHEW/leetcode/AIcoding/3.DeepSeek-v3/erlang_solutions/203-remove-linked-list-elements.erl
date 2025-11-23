-spec remove_elements(Head :: #list_node{} | null, Val :: integer()) -> #list_node{} | null.
remove_elements(null, _Val) -> null;
remove_elements(Head, Val) ->
    case Head#list_node.val of
        Val -> remove_elements(Head#list_node.next, Val);
        _ ->
            #list_node{
                val = Head#list_node.val,
                next = remove_elements(Head#list_node.next, Val)
            }
    end.