%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec binary_tree_paths(Root :: #tree_node{} | null) -> [unicode:unicode_binary()].
binary_tree_paths(null) -> [];
binary_tree_paths(#tree_node{val = Val, left = null, right = null}) ->
    [integer_to_list(Val)];
binary_tree_paths(#tree_node{val = Val, left = Left, right = Right}) ->
    lists:flatmap(fun(Path) -> ["~s->" ++ Path] end,
                  binary_tree_paths(Left) ++ binary_tree_paths(Right)).
