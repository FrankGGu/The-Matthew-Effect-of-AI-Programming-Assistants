-spec merge_nodes(Head :: #list_node{} | null) -> #list_node{} | null.
merge_nodes(Head) ->
    case Head of
        null -> null;
        _ ->
            NewHead = #list_node{val = 0, next = null},
            Current = NewHead,
            Sum = 0,
            Node = Head#list_node.next,
            merge_nodes_loop(Node, Current, Sum, NewHead)
    end.

merge_nodes_loop(Node, Current, Sum, NewHead) ->
    case Node of
        null ->
            NewHead#list_node.next;
        _ ->
            case Node#list_node.val of
                0 ->
                    NewNode = #list_node{val = Sum, next = null},
                    Current#list_node.next = NewNode,
                    NewCurrent = NewNode,
                    NewSum = 0,
                    merge_nodes_loop(Node#list_node.next, NewCurrent, NewSum, NewHead);
                Val ->
                    NewSum = Sum + Val,
                    merge_nodes_loop(Node#list_node.next, Current, NewSum, NewHead)
            end
    end.