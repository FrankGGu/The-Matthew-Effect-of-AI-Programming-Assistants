-spec build_tree(Inorder :: [integer()], Postorder :: [integer()]) -> TreeNode | nil.
build_tree(Inorder, Postorder) ->
    case Inorder of
        [] -> nil;
        _ ->
            {RootVal, LeftIn, RightIn} = split_tree(Inorder, Postorder),
            #{
                val => RootVal,
                left => build_tree(LeftIn, lists:sublist(Postorder, length(LeftIn))),
                right => build_tree(RightIn, lists:sublist(Postorder, length(LeftIn), length(Postorder) - length(LeftIn) - 1))
            }
    end.

split_tree(Inorder, Postorder) ->
    RootVal = lists:last(Postorder),
    {LeftIn, [_ | RightIn]} = lists:splitwith(fun(X) -> X =/= RootVal end, Inorder),
    {RootVal, LeftIn, RightIn}.