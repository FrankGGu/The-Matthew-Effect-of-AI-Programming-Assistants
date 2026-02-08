-module(range_sum_bst).
-export([range_sum_bst/3]).

-spec range_sum_bst(TreeNode(), integer(), integer()) -> integer().
range_sum_bst(null, _Low, _High) ->
    0;
range_sum_bst({Val, Left, Right}, Low, High) ->
    Sum =
        case Val of
            V when V >= Low andalso V =< High ->
                Val;
            _ ->
                0
        end,
    Sum + range_sum_bst(Left, Low, High) + range_sum_bst(Right, Low, High).

-type TreeNode() :: {integer(), TreeNode(), TreeNode()} | null.