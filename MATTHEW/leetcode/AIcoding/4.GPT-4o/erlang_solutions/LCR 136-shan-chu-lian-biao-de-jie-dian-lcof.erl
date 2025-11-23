-module(solution).
-export([delete_node/1]).

-record(node, {val, next}).

delete_node(Node) ->
    Next = Node#node.next,
    Node#node.val = Next#node.val,
    Node#node.next = Next#node.next.