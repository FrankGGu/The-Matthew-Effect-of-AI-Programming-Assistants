-record(child_node, {
    val :: integer(),
    prev :: 'null' | #child_node{},
    next :: 'null' | #child_node{},
    child :: 'null' | #child_node{}
}).

-spec flatten(Head :: #child_node{} | null) -> #child_node{} | null.
flatten(Head) ->
    case Head of
        null -> null;
        _ ->
            flatten_helper(Head),
            Head
    end.

flatten_helper(Node) ->
    case Node of
        null -> null;
        _ ->
            Next = Node#child_node.next,
            Child = Node#child_node.child,
            case Child of
                null -> 
                    flatten_helper(Next);
                _ ->
                    flatten_helper(Child),
                    Tail = get_tail(Child),
                    Node#child_node.next = Child,
                    Child#child_node.prev = Node,
                    Node#child_node.child = null,
                    Tail#child_node.next = Next,
                    case Next of
                        null -> ok;
                        _ -> Next#child_node.prev = Tail
                    end,
                    flatten_helper(Next)
            end
    end.

get_tail(Node) ->
    case Node#child_node.next of
        null -> Node;
        Next -> get_tail(Next)
    end.