%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec lowest_common_ancestor(Root :: #tree_node{} | null, P :: #tree_node{}, Q :: #tree_node{}) -> #tree_node{} | null.
lowest_common_ancestor(Root, P, Q) ->
    case Root of
        null -> null;
        #tree_node{val = Val, left = Left, right = Right} when Val > P#tree_node.val, Val > Q#tree_node.val ->
            lowest_common_ancestor(Left, P, Q);
        #tree_node{val = Val, left = Left, right = Right} when Val < P#tree_node.val, Val < Q#tree_node.val ->
            lowest_common_ancestor(Right, P, Q);
        _ -> Root
    end.
