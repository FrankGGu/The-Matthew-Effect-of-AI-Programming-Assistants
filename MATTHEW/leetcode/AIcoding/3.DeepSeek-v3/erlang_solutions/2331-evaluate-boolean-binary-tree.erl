-spec evaluate_tree(Root :: #tree_node{} | null) -> boolean().
evaluate_tree(null) -> false;
evaluate_tree(#tree_node{val = Val, left = null, right = null}) ->
    Val == 1;
evaluate_tree(#tree_node{val = Val, left = Left, right = Right}) ->
    LeftVal = evaluate_tree(Left),
    RightVal = evaluate_tree(Right),
    case Val of
        2 -> LeftVal orelse RightVal;
        3 -> LeftVal andalso RightVal
    end.