-spec middle_node(Head :: #list_node{} | null) -> #list_node{} | null.
middle_node(Head) ->
    case Head of
        null -> null;
        _ ->
            Slow = Head,
            Fast = Head,
            middle_node_helper(Slow, Fast)
    end.

middle_node_helper(Slow, Fast) ->
    case Fast#list_node.next of
        null -> Slow;
        NextFast ->
            case NextFast#list_node.next of
                null -> Slow#list_node.next;
                NextNextFast ->
                    middle_node_helper(Slow#list_node.next, NextNextFast)
            end
    end.