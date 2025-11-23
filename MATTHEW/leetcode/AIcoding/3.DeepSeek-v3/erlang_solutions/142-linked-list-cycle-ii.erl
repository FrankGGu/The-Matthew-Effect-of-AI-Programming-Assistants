-spec detectCycle(Node :: #list_node{} | null) -> #list_node{} | null.
detectCycle(Node) ->
    case Node of
        null -> null;
        _ ->
            Slow = Node,
            Fast = Node,
            detectCycle(Slow, Fast)
    end.

-spec detectCycle(Slow :: #list_node{}, Fast :: #list_node{}) -> #list_node{} | null.
detectCycle(Slow, Fast) ->
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
                            findStart(Node, NewSlow);
                        true ->
                            detectCycle(NewSlow, NewFast)
                    end
            end
    end.

-spec findStart(Node :: #list_node{}, Meet :: #list_node{}) -> #list_node{} | null.
findStart(Node, Meet) ->
    if
        Node =:= Meet -> Node;
        true ->
            NewNode = Node#list_node.next,
            NewMeet = Meet#list_node.next,
            findStart(NewNode, NewMeet)
    end.