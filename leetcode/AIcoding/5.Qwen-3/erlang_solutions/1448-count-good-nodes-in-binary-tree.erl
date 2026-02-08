-module(solution).
-export([good_nodes/1]).

-type tree() :: 'null' | {integer(), tree(), tree()}.

-good_nodes(null) -> 0;
-good_nodes({Val, Left, Right}) ->
    count_good_nodes({Val, Left, Right}, Val).

count_good_nodes(null, _) -> 0;
count_good_nodes({Val, Left, Right}, MaxSoFar) ->
    Count = if Val >= MaxSoFar -> 1; true -> 0 end,
    LeftCount = count_good_nodes(Left, max(Val, MaxSoFar)),
    RightCount = count_good_nodes(Right, max(Val, MaxSoFar)),
    Count + LeftCount + RightCount.