-spec check_tree(Root :: #tree_node{} | null) -> boolean().
check_tree(Root) ->
    case Root of
        null -> false;
        #tree_node{val = Val, left = Left, right = Right} ->
            LeftVal = case Left of
                null -> 0;
                #tree_node{val = LVal} -> LVal
            end,
            RightVal = case Right of
                null -> 0;
                #tree_node{val = RVal} -> RVal
            end,
            Val =:= LeftVal + RightVal
    end.