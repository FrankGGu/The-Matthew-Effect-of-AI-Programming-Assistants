-spec is_balanced(Root :: #tree_node{} | null) -> boolean().
is_balanced(null) -> true;
is_balanced(Root) ->
    case check_height(Root) of
        {balanced, _} -> true;
        _ -> false
    end.

check_height(null) -> {balanced, 0};
check_height(#tree_node{left = Left, right = Right}) ->
    case check_height(Left) of
        {balanced, LeftHeight} ->
            case check_height(Right) of
                {balanced, RightHeight} when abs(LeftHeight - RightHeight) =< 1 ->
                    Height = max(LeftHeight, RightHeight) + 1,
                    {balanced, Height};
                _ ->
                    unbalanced
            end;
        _ ->
            unbalanced
    end.