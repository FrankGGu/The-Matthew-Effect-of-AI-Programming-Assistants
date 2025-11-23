-module(solution).
-export([max_sum_bst/1]).

-record(node, {val, left = none, right = none}).

max_sum_bst(Tree) ->
    {MaxSum, _} = max_sum_bst_helper(Tree),
    MaxSum.

max_sum_bst_helper(none) -> {0, 1} ;
max_sum_bst_helper(#node{val=Val, left=Left, right=Right}) ->
    {LeftSum, IsLeftBST} = max_sum_bst_helper(Left),
    {RightSum, IsRightBST} = max_sum_bst_helper(Right),
    case {IsLeftBST, IsRightBST, Val, Left, Right} of
        {1, 1, L, none, none} when L < Val -> 
            {LeftSum + RightSum + Val, 1};
        {1, 1, L, none, #node{val=R}} when L < Val, R > Val -> 
            {LeftSum + RightSum + Val, 1};
        {1, 1, L, #node{val=L}, none} when L < Val -> 
            {LeftSum + RightSum + Val, 1};
        {1, 1, L, #node{val=L}, #node{val=R}} when L < Val, R > Val -> 
            {LeftSum + RightSum + Val, 1};
        _ -> 
            {max(LeftSum, RightSum), 0}
    end.