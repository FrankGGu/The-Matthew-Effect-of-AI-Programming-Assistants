-module(maximum_difference_between_node_and_ancestor).
-export([maxAncestorDiff/1]).

maxAncestorDiff(Root) ->
    maxAncestorDiff(Root, 0, 0).

maxAncestorDiff(null, Min, Max) ->
    Max - Min;
maxAncestorDiff({Val, Left, Right}, Min, Max) ->
    NewMin = min(Min, Val),
    NewMax = max(Max, Val),
    LeftResult = maxAncestorDiff(Left, NewMin, NewMax),
    RightResult = maxAncestorDiff(Right, NewMin, NewMax),
    max(LeftResult, RightResult).