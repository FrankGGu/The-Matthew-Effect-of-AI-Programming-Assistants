-module(solution).
-export([binary_tree_paths/1]).

binary_tree_paths(nil) -> [];
binary_tree_paths({Val, nil, nil}) -> [integer_to_list(Val)];
binary_tree_paths({Val, Left, Right}) ->
    LeftPaths = case Left of
                    nil -> [];
                    _ -> [integer_to_list(Val) ++ "->" ++ P || P <- binary_tree_paths(Left)]
                end,
    RightPaths = case Right of
                     nil -> [];
                     _ -> [integer_to_list(Val) ++ "->" ++ P || P <- binary_tree_paths(Right)]
                 end,
    LeftPaths ++ RightPaths.