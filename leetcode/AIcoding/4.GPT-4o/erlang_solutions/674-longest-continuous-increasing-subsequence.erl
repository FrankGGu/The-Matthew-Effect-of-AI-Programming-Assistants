-module(solution).
-export([longest_increasing_subsequence/1]).

longest_increasing_subsequence(List) ->
    longest_increasing_subsequence(List, 0, 0).

longest_increasing_subsequence([], CurrentLength, MaxLength) ->
    MaxLength;
longest_increasing_subsequence([_], CurrentLength, MaxLength) ->
    max(CurrentLength + 1, MaxLength);
longest_increasing_subsequence([H1, H2 | T], CurrentLength, MaxLength) ->
    NewCurrentLength = if H2 > H1 -> CurrentLength + 1; true -> 0 end,
    longest_increasing_subsequence([H2 | T], NewCurrentLength, max(MaxLength, NewCurrentLength + 1)).