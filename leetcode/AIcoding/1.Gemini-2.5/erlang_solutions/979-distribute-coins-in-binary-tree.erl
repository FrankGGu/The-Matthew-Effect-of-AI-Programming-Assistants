-module(solution).
-export([distributeCoins/1]).

-record('TreeNode', {val, left = nil, right = nil}).

distributeCoins(Root) ->
    {_Excess, TotalMoves} = dfs(Root),
    TotalMoves.

dfs(nil) ->
    {0, 0};
dfs(#'TreeNode'{val = Val, left = Left, right = Right}) ->
    {LeftExcess, LeftMoves} = dfs(Left),
    {RightExcess, RightMoves} = dfs(Right),

    CurrentExcess = Val + LeftExcess + RightExcess - 1,
    CurrentMoves = abs(LeftExcess) + abs(RightExcess),

    {CurrentExcess, LeftMoves + RightMoves + CurrentMoves}.