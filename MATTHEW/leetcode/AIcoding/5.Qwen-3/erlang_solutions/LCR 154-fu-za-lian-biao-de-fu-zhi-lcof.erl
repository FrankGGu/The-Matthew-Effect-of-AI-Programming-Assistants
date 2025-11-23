-module(solve).
-export([copyRandomList/1]).

-record(node, {val, next, random}).

copyRandomList(Node) ->
    case Node of
        false -> false;
        _ -> copy(Node, #{}).
    end.

copy(false, _) -> false;
copy(Node, Map) ->
    case maps:is_key(Node, Map) of
        true -> maps:get(Node, Map);
        false ->
            NewNode = #node{val = Node#node.val},
            maps:put(Node, NewNode, Map),
            NewNode#node.next = copy(Node#node.next, Map),
            NewNode#node.random = copy(Node#node.random, Map),
            NewNode
    end.