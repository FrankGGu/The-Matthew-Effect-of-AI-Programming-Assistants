%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec sum_numbers(Root :: #tree_node{} | null) -> integer().
sum_numbers(null) -> 0;
sum_numbers(#tree_node{val = Val, left = Left, right = Right}) ->
    sum_numbers_helper(Left, Val) + sum_numbers_helper(Right, Val).

-spec sum_numbers_helper(Node :: #tree_node{} | null, Acc :: integer()) -> integer().
sum_numbers_helper(null, Acc) -> Acc;
sum_numbers_helper(#tree_node{val = Val, left = null, right = null}, Acc) ->
    Acc * 10 + Val;
sum_numbers_helper(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    sum_numbers_helper(Left, Acc * 10 + Val) + sum_numbers_helper(Right, Acc * 10 + Val).
