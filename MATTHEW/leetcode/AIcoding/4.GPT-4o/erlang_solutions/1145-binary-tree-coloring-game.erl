-module(solution).
-export([bTreeGameWinningMove/4]).

-record(node, {val, left = null, right = null}).

bTreeGameWinningMove(Root, N, X) ->
    {XCount, LCount, RCount} = count_nodes(Root, X, 0, 0),
    Total = N,
    Max = lists:max([XCount, LCount, RCount, Total - (XCount + LCount + RCount)]),
    Max > Total div 2.

count_nodes(null, _, LCount, RCount) ->
    {0, LCount, RCount};
count_nodes(#node{val = Val, left = Left, right = Right}, X, LCount, RCount) ->
    case Val of
        X ->
            {1 + count_nodes(Left, X, LCount, RCount#node{val = Val, left = Left, right = Right}) + count_nodes(Right, X, LCount, RCount#node{val = Val, left = Left, right = Right}),
            count_nodes(Left, X, LCount, RCount) + 1,
            count_nodes(Right, X, LCount, RCount) + 1};
        _ ->
            {0 + count_nodes(Left, X, LCount, RCount) + count_nodes(Right, X, LCount, RCount), LCount, RCount}
    end.