-module(solution).
-export([maxDepth/1]).

maxDepth(S) ->
    max_depth(S, 0, 0).

max_depth([], MaxDepth, _) ->
    MaxDepth;
max_depth([H | T], MaxDepth, CurrentDepth) ->
    case H of
        $'(' -> max_depth(T, max(CurrentDepth + 1, MaxDepth), CurrentDepth + 1);
        $')' -> max_depth(T, MaxDepth, CurrentDepth - 1);
        _ -> max_depth(T, MaxDepth, CurrentDepth)
    end.