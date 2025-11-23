-spec build_tree(Inorder :: [integer()], Postorder :: [integer()]) -> TreeNode | nil.
build_tree(Inorder, Postorder) ->
    case Inorder of
        [] -> nil;
        _ ->
            RootVal = lists:last(Postorder),
            Root = #{val => RootVal, left => nil, right => nil},
            Index = index_of(RootVal, Inorder),
            LeftIn = lists:sublist(Inorder, Index - 1),
            RightIn = lists:nthtail(Index, Inorder),
            LeftPost = lists:sublist(Postorder, Index - 1),
            RightPost = lists:sublist(Postorder, Index, length(Postorder) - Index),
            Root#{left => build_tree(LeftIn, LeftPost),
                 right => build_tree(RightIn, RightPost)}
    end.

index_of(Val, List) ->
    index_of(Val, List, 1).

index_of(Val, [Val | _], Index) -> Index;
index_of(Val, [_ | T], Index) -> index_of(Val, T, Index + 1).