-module(minimum_depth_binary_tree).
-export([min_depth/1]).

-record(tree_node, {val, left, right}).

min_depth(Root) ->
  min_depth_helper(Root, 1).

min_depth_helper(null, _) ->
  0;
min_depth_helper(#tree_node{left = null, right = null}, Depth) ->
  Depth;
min_depth_helper(#tree_node{left = Left, right = Right}, Depth) ->
  case {Left, Right} of
    {null, _} ->
      min_depth_helper(Right, Depth + 1);
    {_, null} ->
      min_depth_helper(Left, Depth + 1);
    {_, _} ->
      min(min_depth_helper(Left, Depth + 1), min_depth_helper(Right, Depth + 1))
  end.