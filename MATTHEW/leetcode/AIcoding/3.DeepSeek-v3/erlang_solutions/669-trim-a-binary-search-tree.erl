-spec trim_bst(Root :: #tree_node{} | null, Low :: integer(), High :: integer()) -> #tree_node{} | null.
trim_bst(null, _Low, _High) -> null;
trim_bst(#tree_node{val = Val, left = Left, right = Right}, Low, High) ->
    if
        Val < Low -> trim_bst(Right, Low, High);
        Val > High -> trim_bst(Left, Low, High);
        true ->
            #tree_node{
                val = Val,
                left = trim_bst(Left, Low, High),
                right = trim_bst(Right, Low, High)
            }
    end.