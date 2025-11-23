-module(solution).
-export([find_bottom_left_value/1]).

-spec find_bottom_left_value(TreeNode::treeNode()) -> integer().

-type treeNode() :: {integer(), treeNode(), treeNode()} | nil.

find_bottom_left_value(Root) ->
  find_bottom_left_value(Root, 0, 0, 0, 0).

find_bottom_left_value(nil, _, _, Value, MaxDepth) ->
  {Value, MaxDepth};
find_bottom_left_value({Val, Left, Right}, Depth, MaxDepthAcc, ValueAcc, MaxDepthAcc) ->
  case Depth + 1 > MaxDepthAcc of
    true ->
      {NewValue, NewMaxDepth} = {Val, Depth + 1};
    false ->
      {NewValue, NewMaxDepth} = {ValueAcc, MaxDepthAcc}
  end,
  {RightValue, RightMaxDepth} = find_bottom_left_value(Right, Depth + 1, NewMaxDepth, NewValue, NewMaxDepth),
  {LeftValue, LeftMaxDepth} = find_bottom_left_value(Left, Depth + 1, RightMaxDepth, RightValue, RightMaxDepth),
  {LeftValue, LeftMaxDepth}.