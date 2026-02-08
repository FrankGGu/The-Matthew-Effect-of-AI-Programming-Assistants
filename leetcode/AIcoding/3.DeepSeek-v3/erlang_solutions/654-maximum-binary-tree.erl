-spec construct_maximum_binary_tree(Nums :: [integer()]) -> TreeNode | nil.
construct_maximum_binary_tree(Nums) ->
    case Nums of
        [] -> nil;
        _ ->
            {Max, Left, Right} = split_at_max(Nums),
            #{
                val => Max,
                left => construct_maximum_binary_tree(Left),
                right => construct_maximum_binary_tree(Right)
            }
    end.

split_at_max(List) ->
    split_at_max(List, -1, -1, [], []).

split_at_max([], Max, _, Left, Right) ->
    {Max, lists:reverse(Left), Right};
split_at_max([H | T], Max, Index, Left, Right) when H > Max ->
    NewLeft = Left ++ Right,
    split_at_max(T, H, Index + 1, NewLeft, []);
split_at_max([H | T], Max, Index, Left, Right) ->
    split_at_max(T, Max, Index + 1, Left, Right ++ [H]).