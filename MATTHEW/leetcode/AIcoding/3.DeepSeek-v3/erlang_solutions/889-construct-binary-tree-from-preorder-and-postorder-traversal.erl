-spec construct_from_pre_post(Preorder :: [integer()], Postorder :: [integer()]) -> TreeNode | nil.
construct_from_pre_post(Preorder, Postorder) ->
    case Preorder of
        [] -> nil;
        [RootVal | _] ->
            Root = #{val => RootVal, left => nil, right => nil},
            case length(Preorder) of
                1 -> Root;
                _ ->
                    LeftRootVal = lists:nth(2, Preorder),
                    LeftSubtreeSize = index_of(LeftRootVal, Postorder) + 1,
                    LeftPre = lists:sublist(Preorder, 2, LeftSubtreeSize),
                    LeftPost = lists:sublist(Postorder, LeftSubtreeSize),
                    RightPre = lists:sublist(Preorder, LeftSubtreeSize + 2, length(Preorder) - LeftSubtreeSize - 1),
                    RightPost = lists:sublist(Postorder, LeftSubtreeSize + 1, length(Postorder) - LeftSubtreeSize - 1),
                    Root#{left := construct_from_pre_post(LeftPre, LeftPost),
                          right := construct_from_pre_post(RightPre, RightPost)}
            end
    end.

index_of(Val, List) ->
    index_of(Val, List, 0).

index_of(Val, [Val | _], Index) -> Index;
index_of(Val, [_ | T], Index) -> index_of(Val, T, Index + 1).