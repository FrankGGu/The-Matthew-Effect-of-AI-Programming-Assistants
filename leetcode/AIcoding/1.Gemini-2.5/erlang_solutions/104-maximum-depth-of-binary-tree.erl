-spec max_depth(TreeNode :: any()) -> integer().
max_depth(nil) -> 0;
max_depth({_Val, Left, Right}) ->
    1 + max(max_depth(Left), max_depth(Right)).