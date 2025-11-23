%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec is_same_tree(P :: #tree_node{} | null, Q :: #tree_node{} | null) -> boolean().
is_same_tree(null, null) -> true;
is_same_tree(null, _) -> false;
is_same_tree(_, null) -> false;
is_same_tree(#tree_node{val = ValP, left = LeftP, right = RightP},
             #tree_node{val = ValQ, left = LeftQ, right = RightQ}) ->
    ValP =:= ValQ andalso
    is_same_tree(LeftP, LeftQ) andalso
    is_same_tree(RightP, RightQ).
