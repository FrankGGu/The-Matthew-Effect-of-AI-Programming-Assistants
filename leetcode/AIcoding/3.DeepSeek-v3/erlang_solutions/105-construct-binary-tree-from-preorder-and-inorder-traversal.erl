-spec build_tree(Preorder :: [integer()], Inorder :: [integer()]) -> TreeNode | nil.
build_tree(Preorder, Inorder) ->
    case Preorder of
        [] -> nil;
        [RootVal | _] ->
            RootIndex = index_of(RootVal, Inorder),
            LeftInorder = lists:sublist(Inorder, RootIndex - 1),
            RightInorder = lists:nthtail(RootIndex, Inorder),
            LeftPreorder = lists:sublist(Preorder, 2, RootIndex - 1),
            RightPreorder = lists:nthtail(RootIndex + 1, Preorder),
            #{
                val => RootVal,
                left => build_tree(LeftPreorder, LeftInorder),
                right => build_tree(RightPreorder, RightInorder)
            }
    end.

index_of(Val, List) -> index_of(Val, List, 1).

index_of(Val, [Val | _], Index) -> Index;
index_of(Val, [_ | T], Index) -> index_of(Val, T, Index + 1).