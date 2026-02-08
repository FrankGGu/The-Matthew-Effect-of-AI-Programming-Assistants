-spec max_level_sum(Root :: #tree_node{} | null) -> integer().
max_level_sum(null) -> 0;
max_level_sum(Root) ->
    {MaxSum, MaxLevel, _} = bfs([{Root, 1}], -1, 1, 0, -1),
    MaxLevel.

bfs([], MaxSum, MaxLevel, _CurrentSum, _CurrentLevel) ->
    {MaxSum, MaxLevel, 0};
bfs([{null, _} | Rest], MaxSum, MaxLevel, CurrentSum, CurrentLevel) ->
    bfs(Rest, MaxSum, MaxLevel, CurrentSum, CurrentLevel);
bfs([{#tree_node{val = Val, left = Left, right = Right}, Level} | Rest], MaxSum, MaxLevel, CurrentSum, CurrentLevel) ->
    NewCurrentSum = if
        Level =:= CurrentLevel -> CurrentSum + Val;
        true -> Val
    end,
    NewCurrentLevel = if
        Level =:= CurrentLevel -> CurrentLevel;
        true -> Level
    end,
    {NewMaxSum, NewMaxLevel} = if
        Level =/= CurrentLevel andalso CurrentSum > MaxSum -> {CurrentSum, CurrentLevel};
        Level =/= CurrentLevel -> {MaxSum, MaxLevel};
        true -> {MaxSum, MaxLevel}
    end,
    NewRest = Rest ++ [{Left, Level + 1}, {Right, Level + 1}],
    bfs(NewRest, NewMaxSum, NewMaxLevel, NewCurrentSum, NewCurrentLevel).