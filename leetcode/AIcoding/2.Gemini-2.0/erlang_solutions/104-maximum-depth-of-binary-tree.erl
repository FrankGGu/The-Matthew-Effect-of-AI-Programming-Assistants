-module(maximum_depth_binary_tree).
-export([max_depth/1]).

-spec max_depth(TreeNode()) -> integer().
max_depth(null) -> 0;
max_depth(TreeNode) ->
  1 + max(max_depth(TreeNode#tree_node.left), max_depth(TreeNode#tree_node.right)).

-type TreeNode() :: null | #tree_node{}.
-record(tree_node, {val, left :: TreeNode(), right :: TreeNode()}).

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.