-module(solution).
-export([reverse_odd_levels/1]).

-spec reverse_odd_levels(TreeNode::treeNode()) -> treeNode().

reverse_odd_levels(Root) ->
  reverse_odd_levels(Root, 0).

reverse_odd_levels(Node, Level) ->
  case Node of
    null -> null;
    #treeNode{val = Val, left = Left, right = Right} ->
      case Level rem 2 of
        0 ->
          #treeNode{val = Val, left = reverse_odd_levels(Left, Level + 1), right = reverse_odd_levels(Right, Level + 1)};
        1 ->
          {NewLeft, NewRight} = reverse_children(Left, Right, Level + 1),
          #treeNode{val = Val, left = NewLeft, right = NewRight}
      end
  end.

reverse_children(Left, Right, Level) ->
  case {Left, Right} of
    {null, null} -> {null, null};
    {null, _} -> {reverse_odd_levels(Right, Level), null};
    {_, null} -> {null, reverse_odd_levels(Left, Level)};
    {_, _} ->
      {reverse_odd_levels(Right, Level), reverse_odd_levels(Left, Level)}
  end.