-module(solution).
-export([countGoodNodes/1]).

countGoodNodes(nil) ->
    0;
countGoodNodes({Val, Left, Right}) ->
    dfs({Val, Left, Right}, Val).

dfs(nil, _MaxValSoFar) ->
    0;
dfs({Val, Left, Right}, MaxValSoFar) ->
    IsGood = if Val >= MaxValSoFar -> 1;
                true -> 0
             end,
    NewMaxValSoFar = max(Val, MaxValSoFar),
    IsGood + dfs(Left, NewMaxValSoFar) + dfs(Right, NewMaxValSoFar).