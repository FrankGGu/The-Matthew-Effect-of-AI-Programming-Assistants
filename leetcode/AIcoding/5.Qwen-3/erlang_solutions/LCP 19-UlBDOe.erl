-module(solution).
-export([solve/1]).

solve(Tree) ->
    {_, Max} = dfs(Tree),
    Max.

dfs(nil) ->
    {0, 0};
dfs({Val, Left, Right}) ->
    {LCount, LMax} = dfs(Left),
    {RCount, RMax} = dfs(Right),
    Count = LCount + RCount + 1,
    Max = max(LMax, RMax),
    {Count, Max}.