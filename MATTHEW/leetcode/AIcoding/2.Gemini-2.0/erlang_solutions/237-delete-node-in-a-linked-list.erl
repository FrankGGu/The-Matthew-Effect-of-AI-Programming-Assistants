-module(delete_node).
-export([delete_node/1]).

delete_node(Node) ->
  case Node of
    null ->
      ok;
    _ ->
      Next = Node#list_node.next,
      Node#list_node.val ! Next#list_node.val,
      Node#list_node.next ! Next#list_node.next
  end.