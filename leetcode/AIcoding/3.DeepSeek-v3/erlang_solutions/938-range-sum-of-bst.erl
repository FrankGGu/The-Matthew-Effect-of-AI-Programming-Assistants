-record(tree_node, {val = 0 :: integer(),
                    left = null  :: 'null' | #tree_node{},
                    right = null :: 'null' | #tree_node{}}).

-spec range_sum_bst(Root :: #tree_node{} | null, Low :: integer(), High :: integer()) -> integer().
range_sum_bst(null, _Low, _High) -> 0;
range_sum_bst(Root, Low, High) ->
    Sum = if
        Root#tree_node.val >= Low, Root#tree_node.val =< High -> Root#tree_node.val;
        true -> 0
    end,
    Sum + range_sum_bst(Root#tree_node.left, Low, High) + range_sum_bst(Root#tree_node.right, Low, High).