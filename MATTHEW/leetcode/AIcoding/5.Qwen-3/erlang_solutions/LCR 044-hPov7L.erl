-module(solution).
-export([largest_values_from_root_to_leaf/1]).

largest_values_from_root_to_leaf(null) -> [];
largest_values_from_root_to_leaf({TreeNode, Left, Right}) ->
    [TreeNode | largest_values_from_root_to_leaf(Left)] ++ largest_values_from_root_to_leaf(Right).

largest_values_from_root_to_leaf([]) -> [];
largest_values_from_root_to_leaf([null | T]) -> largest_values_from_root_to_leaf(T);
largest_values_from_root_to_leaf([H | T]) ->
    [H | largest_values_from_root_to_leaf(T)].