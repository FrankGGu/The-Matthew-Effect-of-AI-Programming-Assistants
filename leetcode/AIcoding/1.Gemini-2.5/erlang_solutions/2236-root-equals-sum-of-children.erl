-module(solution).
-export([check_tree/1]).

-record('TreeNode', {val, left, right}).

check_tree(#'TreeNode'{val = RootVal, left = #'TreeNode'{val = LeftVal}, right = #'TreeNode'{val = RightVal}}) ->
    RootVal =:= LeftVal + RightVal.