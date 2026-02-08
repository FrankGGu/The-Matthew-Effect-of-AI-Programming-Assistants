-spec find_bottom_left_value(Root :: #tree_node{} | null) -> integer().
find_bottom_left_value(Root) ->
    {Val, _} = traverse(Root, 0, {0, 0}),
    Val.

traverse(null, _Depth, Acc) -> Acc;
traverse(#tree_node{val = Val, left = Left, right = Right}, Depth, {MaxDepth, _}) ->
    NewDepth = Depth + 1,
    case Left =:= null andalso Right =:= null of
        true when NewDepth > MaxDepth -> {Val, NewDepth};
        true -> {MaxDepth, _} = Acc;
        false ->
            LeftAcc = traverse(Left, NewDepth, Acc),
            RightAcc = traverse(Right, NewDepth, Acc),
            case element(2, LeftAcc) >= element(2, RightAcc) of
                true -> LeftAcc;
                false -> RightAcc
            end
    end.