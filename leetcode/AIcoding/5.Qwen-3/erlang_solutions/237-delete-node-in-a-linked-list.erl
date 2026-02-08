-module(delete_node_in_linked_list).
-export([deleteNode/1]).

-record(list_node, {val, next}).

deleteNode(Node) ->
    Next = Node#list_node.next,
    Node#list_node.val = Next#list_node.val,
    Node#list_node.next = Next#list_node.next.