-module(root_equals_sum_children).
-export([root_equals_sum_children/1]).

-spec root_equals_sum_children(TreeNode :: maybe_improper_list(integer(), tree_node())) -> boolean().
root_equals_sum_children(null) -> true;
root_equals_sum_children({Val, Left, Right}) ->
  LeftVal = case Left of
    null -> 0;
    {LV, _, _} -> LV
  end,
  RightVal = case Right of
    null -> 0;
    {RV, _, _} -> RV
  end,
  Val =:= LeftVal + RightVal.

-type tree_node() :: {integer(), tree_node(), tree_node()}.