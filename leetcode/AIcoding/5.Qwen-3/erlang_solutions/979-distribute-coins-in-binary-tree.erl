-module(distribute_coins).
-export([solve/1]).

solve(Root) ->
    {_, _} = dfs(Root),
    ok.

dfs(nil) ->
    {0, 0};
dfs({Val, Left, Right}) ->
    {LeftCoins, LeftMoves} = dfs(Left),
    {RightCoins, RightMoves} = dfs(Right),
    TotalCoins = Val + LeftCoins + RightCoins,
    TotalMoves = LeftMoves + RightMoves + abs(Val - 1) + abs(LeftCoins) + abs(RightCoins),
    {TotalCoins, TotalMoves}.