-spec delete_middle(Head :: #list_node{} | null) -> #list_node{} | null.
delete_middle(Head) ->
    case Head of
        null -> null;
        #list_node{next = null} -> null;
        _ ->
            Slow = Head,
            Fast = Head,
            Prev = null,
            delete_middle_helper(Slow, Fast, Prev)
    end.

delete_middle_helper(Slow, Fast, Prev) ->
    case Fast of
        null -> 
            Prev#list_node{next = Slow#list_node.next};
        #list_node{next = null} -> 
            Prev#list_node{next = Slow#list_node.next};
        #list_node{next = NextFast} ->
            case NextFast of
                null -> 
                    Prev#list_node{next = Slow#list_node.next};
                _ -> 
                    NewPrev = Slow,
                    NewSlow = Slow#list_node.next,
                    NewFast = NextFast#list_node.next,
                    delete_middle_helper(NewSlow, NewFast, NewPrev)
            end
    end.