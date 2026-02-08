-module(solution).
-export([flatten/1]).

-record(node, {
    val,
    prev = null,
    next = null,
    child = null
}).

-spec flatten(Node :: 'null' | #node{}) -> 'null' | #node{}.
flatten(Head) ->
    flatten_list(Head, null),
    Head.

flatten_list(null, Prev) ->
    Prev;
flatten_list(Node, Prev) ->
    Node#node{prev = Prev},
    Next = Node#node.next,
    case Node#node.child of
        null ->
            flatten_list(Next, Node);
        Child ->
            Tail = flatten_list(Child, Node),
            Node1 = Node#node{child = null, next = Child},
            Child#node{prev = Node},
            Tail#node{next = Next},
            case Next of
                null -> ok;
                _ -> Next#node{prev = Tail}
            end,
            flatten_list(Next, Tail)
    end.
