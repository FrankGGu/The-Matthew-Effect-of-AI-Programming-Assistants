%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec recover_tree(Root :: #tree_node{} | null) -> any.
recover_tree(Root) ->
    recover_tree(Root, null, null).

recover_tree(null, _, _) -> ok;
recover_tree(#tree_node{val = Val, left = Left, right = Right}, Prev, Last) ->
    recover_tree(Left, Prev, Last),
    case Prev of
        null -> recover_tree(Right, #tree_node{val = Val, left = Left, right = Right}, null);
        _ -> ok
    end.
