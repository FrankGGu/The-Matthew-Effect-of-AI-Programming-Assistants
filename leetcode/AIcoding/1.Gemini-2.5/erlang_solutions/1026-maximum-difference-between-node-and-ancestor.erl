-module(solution).
-export([max_ancestor_diff/1]).

max_ancestor_diff(nil) ->
    0;
max_ancestor_diff({Val, Left, Right}) ->
    dfs({Val, Left, Right}, Val, Val).

dfs(nil, _, _) ->
    0;
dfs({Val, Left, Right}, MinValSoFar, MaxValSoFar) ->
    Diff1 = abs(Val - MinValSoFar),
    Diff2 = abs(Val - MaxValSoFar),
    CurrentMaxDiff = max(Diff1, Diff2),

    NewMinValSoFar = min(MinValSoFar, Val),
    NewMaxValSoFar = max(MaxValSoFar, Val),

    LeftMaxDiff = dfs(Left, NewMinValSoFar, NewMaxValSoFar),
    RightMaxDiff = dfs(Right, NewMinValSoFar, NewMaxValSoFar),

    max(CurrentMaxDiff, max(LeftMaxDiff, RightMaxDiff)).