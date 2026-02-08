-module(solution).
-export([goodNodes/1]).

goodNodes(nil) -> 0;
goodNodes({Val, Left, Right}) ->
    dfs({Val, Left, Right}, Val).

dfs(nil, _MaxValSoFar) -> 0;
dfs({Val, Left, Right}, MaxValSoFar) ->
    CurrentGood = if Val >= MaxValSoFar -> 1; true -> 0 end,
    NewMaxValSoFar = max(Val, MaxValSoFar),
    CurrentGood + dfs(Left, NewMaxValSoFar) + dfs(Right, NewMaxValSoFar).