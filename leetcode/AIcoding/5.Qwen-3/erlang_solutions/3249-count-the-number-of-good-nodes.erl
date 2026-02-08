-module(solution).
-export([good_nodes/1]).

good_nodes(undefined) -> 0;
good_nodes({Val, Left, Right}) ->
    count_good_nodes(Val, Val, Left, Right).

count_good_nodes(CurrentVal, MaxSoFar, undefined, undefined) ->
    1;
count_good_nodes(CurrentVal, MaxSoFar, Left, Right) ->
    NewMax = max(MaxSoFar, CurrentVal),
    LeftCount = case Left of
        undefined -> 0;
        _ -> count_good_nodes(element(1, Left), NewMax, element(2, Left), element(3, Left))
    end,
    RightCount = case Right of
        undefined -> 0;
        _ -> count_good_nodes(element(1, Right), NewMax, element(2, Right), element(3, Right))
    end,
    1 + LeftCount + RightCount.