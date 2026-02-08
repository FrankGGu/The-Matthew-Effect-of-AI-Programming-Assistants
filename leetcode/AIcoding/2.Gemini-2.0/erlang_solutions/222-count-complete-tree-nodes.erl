-module(count_complete_tree_nodes).
-export([count_nodes/1]).

count_nodes(Root) ->
  count_nodes_helper(Root, 0).

count_nodes_helper(null, Acc) ->
  Acc;
count_nodes_helper(Node, Acc) ->
  count_nodes_helper(Node#tree_node.left, Acc + 1) + count_nodes_helper(Node#tree_node.right, 0).