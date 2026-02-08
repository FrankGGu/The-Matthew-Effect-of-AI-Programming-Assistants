-module(solution).
-export([alternating_groups/1]).

alternating_groups(Colors) ->
    N = length(Colors),
    count_alternating(Colors, N, 0, 0).

count_alternating(_Colors, N, N, Count) ->
    Count;
count_alternating(Colors, N, Index, CurrentCount) ->
    C1 = lists:nth(Index + 1, Colors),
    C2 = lists:nth(((Index + 1) rem N) + 1, Colors),
    C3 = lists:nth(((Index + 2) rem N) + 1, Colors),

    NewCount = if C1 =/= C2 andalso C2 =/= C3 ->
                   CurrentCount + 1;
               true ->
                   CurrentCount
               end,

    count_alternating(Colors, N, Index + 1, NewCount).