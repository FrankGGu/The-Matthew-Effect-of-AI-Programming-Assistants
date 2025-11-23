-module(increasing_bst).
-export([increasing_bst/1]).

-spec increasing_bst(TreeNode()) -> TreeNode().
increasing_bst(Root) ->
  increasing_bst(Root, nil).

increasing_bst(nil, Tail) ->
  Tail;
increasing_bst(Node, Tail) ->
  increasing_bst(Node, nil, Tail).

increasing_bst(Node, Acc, Tail) ->
  case Node of
    nil ->
      Acc;
    #TreeNode{val = Val, left = Left, right = Right} ->
      RightNode = increasing_bst(Right, Tail),
      NewNode = #TreeNode{val = Val, left = nil, right = RightNode},
      increasing_bst(Left, NewNode);
    _ ->
      Acc
  end.

-type TreeNode() :: nil | #TreeNode{val :: integer(), left :: TreeNode(), right :: TreeNode()}.
-record(TreeNode, {val, left, right}).