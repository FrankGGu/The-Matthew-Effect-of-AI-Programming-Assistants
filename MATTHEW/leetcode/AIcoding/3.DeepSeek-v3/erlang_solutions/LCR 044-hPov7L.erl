-spec largest_values(Root :: #tree_node{} | null) -> [integer()].
largest_values(Root) ->
    case Root of
        null -> [];
        _ -> bfs([Root], [])
    end.

bfs([], Acc) ->
    lists:reverse(Acc);
bfs(Level, Acc) ->
    {Max, NextLevel} = process_level(Level, -1 bsl 31, []),
    bfs(NextLevel, [Max | Acc]).

process_level([], Max, NextLevel) ->
    {Max, lists:reverse(NextLevel)};
process_level([#tree_node{val = Val, left = Left, right = Right} | Rest], Max, NextLevel) ->
    NewMax = max(Val, Max),
    NewNextLevel = case Left of
        null -> NextLevel;
        _ -> [Left | NextLevel]
    end,
    NewNextLevel2 = case Right of
        null -> NewNextLevel;
        _ -> [Right | NewNextLevel]
    end,
    process_level(Rest, NewMax, NewNextLevel2).