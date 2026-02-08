-module(solution).
-export([middle_node/1]).

-record(list_node, {val = 0, next = nil}).

middle_node(Head) ->
    middle_node_recursive(Head, Head).

middle_node_recursive(Slow, nil) ->
    Slow;
middle_node_recursive(Slow, #list_node{next = nil}) ->
    Slow;
middle_node_recursive(Slow, #list_node{next = #list_node{next = NextNextFast}}) ->
    middle_node_recursive(Slow#list_node.next, NextNextFast).