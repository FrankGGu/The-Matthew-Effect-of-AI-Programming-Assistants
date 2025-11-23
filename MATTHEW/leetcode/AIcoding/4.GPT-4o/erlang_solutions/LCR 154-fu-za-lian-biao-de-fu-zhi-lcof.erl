-module(solution).
-export([copyRandomList/1]).

-record(node, {val, next = null, random = null}).

copyRandomList(List) ->
    case List of
        null -> null;
        _ ->
            NewList = create_copy(List, #{}, null),
            restore_random(List, NewList, #{})
    end.

create_copy(null, _, _) -> null;
create_copy(Node, M, Prev) ->
    case maps:get(Node, M, undefined) of
        undefined ->
            NewNode = #node{val = Node#node.val},
            M1 = maps:put(Node, NewNode, M),
            NewNode#node.next = create_copy(Node#node.next, M1, NewNode),
            NewNode;
        NewNode -> NewNode
    end.

restore_random(null, _, _) -> null;
restore_random(Node, NewList, M) ->
    case maps:get(Node, M, undefined) of
        undefined ->
            NewNode = maps:get(Node, NewList),
            NewNode#node.random = maps:get(Node#node.random, NewList, null),
            restore_random(Node#node.next, NewList, maps:put(Node, NewNode, M));
        NewNode -> NewNode
    end.