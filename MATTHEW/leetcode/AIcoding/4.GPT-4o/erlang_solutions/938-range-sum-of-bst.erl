-module(solution).
-export([range_sum_bst/3]).

-record(tree_node, {val, left, right}).

range_sum_bst(Root, Low, High) ->
    case Root of
        null -> 0;
        _ when Root#tree_node.val < Low -> range_sum_bst(Root#tree_node.right, Low, High);
        _ when Root#tree_node.val > High -> range_sum_bst(Root#tree_node.left, Low, High);
        _ -> Root#tree_node.val + range_sum_bst(Root#tree_node.left, Low, High) + range_sum_bst(Root#tree_node.right, Low, High)
    end.