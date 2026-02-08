-module(delete_node_bst).
-export([delete_node/2]).

-spec delete_node(TreeNode(), integer()) -> TreeNode().
delete_node(Root, Key) ->
  delete_node_helper(Root, Key).

delete_node_helper(null, _) ->
  null;
delete_node_helper(TreeNode{val = Val, left = Left, right = Right}, Key) when Val > Key ->
  TreeNode{val = Val, left = delete_node_helper(Left, Key), right = Right};
delete_node_helper(TreeNode{val = Val, left = Left, right = Right}, Key) when Val < Key ->
  TreeNode{val = Val, left = Left, right = delete_node_helper(Right, Key)};
delete_node_helper(TreeNode{left = null, right = Right}, _) ->
  Right;
delete_node_helper(TreeNode{left = Left, right = null}, _) ->
  Left;
delete_node_helper(TreeNode{left = Left, right = Right}, _) ->
  {Succ, NewRight} = find_min_and_delete(Right),
  TreeNode{val = Succ, left = Left, right = NewRight}.

find_min_and_delete(TreeNode{val = Val, left = null, right = Right}) ->
  {Val, Right};
find_min_and_delete(TreeNode{val = Val, left = Left, right = Right}) ->
  {Min, NewLeft} = find_min_and_delete(Left),
  {Min, TreeNode{val = Val, left = NewLeft, right = Right}}.

-type TreeNode() :: null | #{val := integer(), left := TreeNode(), right := TreeNode()}.