-spec sum_numbers(Root :: #tree_node{} | null) -> integer().
sum_numbers(null) -> 0;
sum_numbers(Root) -> 
    helper(Root, 0).

helper(null, Acc) -> 0;
helper(#tree_node{val = Val, left = null, right = null}, Acc) ->
    Acc * 10 + Val;
helper(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
    NewAcc = Acc * 10 + Val,
    helper(Left, NewAcc) + helper(Right, NewAcc).