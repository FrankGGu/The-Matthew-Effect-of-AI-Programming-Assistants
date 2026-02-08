-module(solution).
-export([countSubTrees/1]).

countSubTrees(Root) ->
    {_, Result} = dfs(Root, #{}),
    Result.

dfs(nil, Acc) ->
    {0, Acc};
dfs({Val, Left, Right}, Acc) ->
    {LeftCount, LeftAcc} = dfs(Left, Acc),
    {RightCount, RightAcc} = dfs(Right, LeftAcc),
    NewAcc = maps:update_with(Val, fun(V) -> V + 1 end, 1, RightAcc),
    {LeftCount + RightCount + 1, NewAcc}.