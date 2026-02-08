-spec distribute_coins(Root :: #tree_node{} | null) -> integer().
distribute_coins(Root) ->
    {_, Moves} = dfs(Root),
    Moves.

dfs(null) ->
    {0, 0};
dfs(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftCoins, LeftMoves} = dfs(Left),
    {RightCoins, RightMoves} = dfs(Right),
    Coins = Val + LeftCoins + RightCoins - 1,
    Moves = LeftMoves + RightMoves + abs(LeftCoins) + abs(RightCoins),
    {Coins, Moves}.