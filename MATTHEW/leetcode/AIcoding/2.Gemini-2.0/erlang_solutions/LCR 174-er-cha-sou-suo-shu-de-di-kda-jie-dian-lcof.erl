-module(find_bst_node).

-export([inorderSuccessor/1, inorderPredecessor/1]).

-spec inorderSuccessor(TreeNode()) -> TreeNode().
inorderSuccessor(Root) ->
  inorderSuccessor(Root, null).

inorderSuccessor(null, Acc) ->
  Acc;
inorderSuccessor(Root, Acc) ->
  case Root#tree_node.val of
    Value when Value > Target ->
      inorderSuccessor(Root#tree_node.left, Root);
    Value when Value < Target ->
      inorderSuccessor(Root#tree_node.right, Acc);
    Value when Value == Target ->
      case Root#tree_node.right of
        null -> Acc;
        Right ->
          findMin(Right)
      end
  end.

findMin(Node) ->
  case Node#tree_node.left of
    null -> Node;
    Left -> findMin(Left)
  end.

-spec inorderPredecessor(TreeNode()) -> TreeNode().
inorderPredecessor(Root) ->
  inorderPredecessor(Root, null).

inorderPredecessor(null, Acc) ->
  Acc;
inorderPredecessor(Root, Acc) ->
  case Root#tree_node.val of
    Value when Value < Target ->
      inorderPredecessor(Root#tree_node.right, Root);
    Value when Value > Target ->
      inorderPredecessor(Root#tree_node.left, Acc);
    Value when Value == Target ->
      case Root#tree_node.left of
        null -> Acc;
        Left ->
          findMax(Left)
      end
  end.

findMax(Node) ->
  case Node#tree_node.right of
    null -> Node;
    Right -> findMax(Right)
  end.

-record(tree_node, {val, left, right}).

-type TreeNode() :: #tree_node{}.

-define(Target, target()).

target() -> 0. % Placeholder, replace with actual target value.