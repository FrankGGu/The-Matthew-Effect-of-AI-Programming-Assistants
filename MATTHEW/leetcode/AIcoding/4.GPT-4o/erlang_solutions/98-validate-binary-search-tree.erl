%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec is_valid_bst(Root :: #tree_node{} | null) -> boolean().
is_valid_bst(Root) ->
    is_valid_bst(Root, -inf, inf).

-spec is_valid_bst(Root :: #tree_node{} | null, Min :: integer(), Max :: integer()) -> boolean().
is_valid_bst(null, _, _) -> true;
is_valid_bst(#tree_node{val = Val, left = Left, right = Right}, Min, Max) when Val > Min, Val < Max ->
    is_valid_bst(Left, Min, Val) andalso is_valid_bst(Right, Val, Max);
is_valid_bst(_, _, _) -> false.
