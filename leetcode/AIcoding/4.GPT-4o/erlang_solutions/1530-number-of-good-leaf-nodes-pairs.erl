-module(solution).
-export([countPairs/2]).

-record(tree, {val, left = none, right = none}).

countPairs(Tree, distance) ->
    {Count, _} = countPairsHelper(Tree, distance, 0),
    Count.

countPairsHelper(none, _, _) -> {0, []};
countPairsHelper(#tree{left=Left, right=Right}, distance, depth) ->
    {LeftCount, LeftDepths} = countPairsHelper(Left, distance, depth + 1),
    {RightCount, RightDepths} = countPairsHelper(Right, distance, depth + 1),
    NewDepths = [depth + 1 | LeftDepths ++ RightDepths],
    Pairs = countValidPairs(NewDepths, distance),
    {LeftCount + RightCount + Pairs, NewDepths}.

countValidPairs(Depths, distance) ->
    lists:foldl(fun(X, Acc) -> Acc + countInRange(X, Depths, distance) end, 0, Depths).

countInRange(X, Depths, distance) ->
    lists:foldl(fun(Y, Acc) -> if
        Y > X, Y - X < distance -> Acc + 1;
        true -> Acc
    end, 0, Depths).