-module(solution).
-export([countGoodSubstrings/1]).

-spec countGoodSubstrings(S :: unicode:unicode_list()) -> integer().
countGoodSubstrings(S) ->
    countGoodSubstrings(S, 0).

countGoodSubstrings(S, Count) when length(S) < 3 ->
    Count;
countGoodSubstrings([C1, C2, C3 | Rest], Count) ->
    NewCount = if
                   C1 =/= C2 andalso C1 =/= C3 andalso C2 =/= C3 ->
                       Count + 1;
                   true ->
                       Count
               end,
    countGoodSubstrings([C2, C3 | Rest], NewCount).