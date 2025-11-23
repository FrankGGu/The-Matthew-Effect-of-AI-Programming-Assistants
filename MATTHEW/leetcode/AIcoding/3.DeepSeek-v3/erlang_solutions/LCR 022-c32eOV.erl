-spec detect_cycle(Head :: #list_node{} | null) -> #list_node{} | null.
detect_cycle(Head) ->
    case Head of
        null -> null;
        _ ->
            Slow = Head,
            Fast = Head,
            detect_cycle(Slow, Fast)
    end.

detect_cycle(Slow, Fast) ->
    case Fast of
        null -> null;
        #list_node{next = null} -> null;
        #list_node{next = NextFast} ->
            case NextFast of
                null -> null;
                #list_node{next = NextNextFast} ->
                    NewSlow = Slow#list_node.next,
                    NewFast = NextNextFast,
                    if
                        NewSlow =:= NewFast ->
                            find_start(Head, NewSlow);
                        true ->
                            detect_cycle(NewSlow, NewFast)
                    end
            end
    end.

find_start(Head, Meet) ->
    if
        Head =:= Meet -> Head;
        true ->
            NewHead = Head#list_node.next,
            NewMeet = Meet#list_node.next,
            find_start(NewHead, NewMeet)
    end.