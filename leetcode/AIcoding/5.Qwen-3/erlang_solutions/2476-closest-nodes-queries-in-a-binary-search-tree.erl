-module(closest_nodes).
-export([closestNodes/2]).

-record(bst, {val, left, right}).

closestNodes(Queries, Root) ->
    lists:map(fun(Q) -> findClosest(Root, Q) end, Queries).

findClosest(undefined, _) -> [0, 0];
findClosest(#bst{val = Val, left = Left, right = Right}, Target) ->
    {Min, Max} = findMinMax(Root),
    case Val of
        Val when Val == Target -> [Val, Val];
        _ ->
            {MinVal, MaxVal} = findClosestHelper(Root, Target, Val, Val),
            [MinVal, MaxVal]
    end.

findMinMax(undefined) -> {0, 0};
findMinMax(#bst{val = Val, left = Left, right = Right}) ->
    {LeftMin, LeftMax} = findMinMax(Left),
    {RightMin, RightMax} = findMinMax(Right),
    Min = min(Val, min(LeftMin, RightMin)),
    Max = max(Val, max(LeftMax, RightMax)),
    {Min, Max}.

findClosestHelper(undefined, _, Min, Max) -> {Min, Max};
findClosestHelper(#bst{val = Val, left = Left, right = Right}, Target, Min, Max) ->
    CurrentMin = if Val < Target -> min(Min, Val); true -> Min end,
    CurrentMax = if Val > Target -> max(Max, Val); true -> Max end,
    case Val of
        Val when Val == Target -> {Val, Val};
        _ ->
            LeftResult = findClosestHelper(Left, Target, CurrentMin, CurrentMax),
            RightResult = findClosestHelper(Right, Target, CurrentMin, CurrentMax),
            {min(element(1, LeftResult), element(1, RightResult)), max(element(2, LeftResult), element(2, RightResult))}
    end.