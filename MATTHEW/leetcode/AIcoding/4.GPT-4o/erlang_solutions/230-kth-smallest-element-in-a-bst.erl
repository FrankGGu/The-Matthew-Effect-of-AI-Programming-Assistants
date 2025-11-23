%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec kth_smallest(Root :: #tree_node{} | null, K :: integer()) -> integer().
kth_smallest(Root, K) ->
    kth_smallest(Root, K, 0, []).

kth_smallest(null, _, _, Acc) -> hd(Acc);
kth_smallest(#tree_node{val = Val, left = Left, right = Right}, K, Count, Acc) ->
    % Traverse left subtree
    kth_smallest(Left, K, Count, Acc ++ [Val]);
kth_smallest(#tree_node{val = Val, left = Left, right = Right}, K, Count, Acc) when length(Acc) < K ->
    % Traverse right subtree
    kth_smallest(Right, K, Count + 1, Acc ++ [Val]).
