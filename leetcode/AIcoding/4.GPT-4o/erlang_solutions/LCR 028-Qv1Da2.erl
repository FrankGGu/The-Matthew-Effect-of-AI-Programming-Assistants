-module(flatten_multilevel_doubly_linked_list).
-export([flatten/1]).

-record(node, {val, prev = null, next = null, child = null}).

flatten(Root) ->
    case Root of
        null -> null;
        _ -> 
            Flattened = flatten_helper(Root, null),
            Flattened
    end.

flatten_helper(Node, Prev) ->
    case Node of
        null -> Prev;
        _ ->
            Node1 = Node#node{prev = Prev},
            case Node#node.child of
                null -> 
                    case Node#node.next of
                        null -> Node1;
                        Next -> 
                            Node1#node{next = flatten_helper(Next, Node1)}
                    end;
                Child -> 
                    ChildHead = flatten_helper(Child, Node1),
                    case Node#node.next of
                        null -> 
                            Node1#node{next = ChildHead};
                        Next -> 
                            Node1#node{next = ChildHead},
                            ChildTail = get_tail(ChildHead),
                            ChildTail#node{next = flatten_helper(Next, ChildTail)}
                    end
            end
    end.

get_tail(Node) ->
    case Node of
        null -> null;
        _ ->
            case Node#node.next of
                null -> Node;
                Next -> get_tail(Next)
            end
    end.