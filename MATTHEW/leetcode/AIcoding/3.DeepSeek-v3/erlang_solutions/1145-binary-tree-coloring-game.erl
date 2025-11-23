-spec btree_game_winning_move(Root :: #tree_node{} | null, N :: integer(), X :: integer()) -> boolean().
btree_game_winning_move(Root, N, X) ->
    {LeftCount, RightCount} = count_nodes(Root, X),
    ParentCount = N - LeftCount - RightCount - 1,
    MaxCount = lists:max([LeftCount, RightCount, ParentCount]),
    MaxCount > (N div 2).

count_nodes(null, _) -> {0, 0};
count_nodes(#tree_node{val = Val, left = Left, right = Right}, X) ->
    if
        Val =:= X ->
            LeftCount = count_all_nodes(Left),
            RightCount = count_all_nodes(Right),
            {LeftCount, RightCount};
        true ->
            {LeftCount, RightCount} = count_nodes(Left, X),
            if
                LeftCount =/= 0 orelse RightCount =/= 0 ->
                    {LeftCount, RightCount};
                true ->
                    count_nodes(Right, X)
            end
    end.

count_all_nodes(null) -> 0;
count_all_nodes(#tree_node{left = Left, right = Right}) ->
    1 + count_all_nodes(Left) + count_all_nodes(Right).