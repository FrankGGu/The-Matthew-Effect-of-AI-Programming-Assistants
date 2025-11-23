-module(solution).
-export([num_ways/1]).

num_ways(Root) ->
    {_, Count} = dfs(Root),
    Count rem 1000000007.

dfs(nil) ->
    {0, 1};
dfs(Node) ->
    {LeftCount, LeftVal} = dfs(Node#node.left),
    {RightCount, RightVal} = dfs(Node#node.right),
    Total = (LeftVal * RightVal) rem 1000000007,
    {LeftCount + RightCount + 1, Total}.