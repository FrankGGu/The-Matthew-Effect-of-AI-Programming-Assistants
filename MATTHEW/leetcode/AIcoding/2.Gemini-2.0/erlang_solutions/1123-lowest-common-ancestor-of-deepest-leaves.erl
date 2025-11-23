-module(lca_deepest_leaves).
-export([lowest_common_ancestor_deepest_leaves/1]).

-record(node, {val, left, right}).

lowest_common_ancestor_deepest_leaves(Root) ->
  {_, Node} = deepest_leaves_helper(Root, 0),
  Node.

deepest_leaves_helper(null, Depth) ->
  {Depth, null};
deepest_leaves_helper(Node, Depth) ->
  Left = deepest_leaves_helper(Node#node.left, Depth + 1),
  Right = deepest_leaves_helper(Node#node.right, Depth + 1),
  {LeftDepth, LeftNode} = Left,
  {RightDepth, RightNode} = Right,
  case LeftDepth > RightDepth of
    true ->
      {LeftDepth, LeftNode};
    false ->
      case RightDepth > LeftDepth of
        true ->
          {RightDepth, RightNode};
        false ->
          {LeftDepth, Node}
      end
  end.