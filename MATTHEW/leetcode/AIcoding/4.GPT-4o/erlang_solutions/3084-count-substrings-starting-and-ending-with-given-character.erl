-module(solution).
-export([countSubstrings/3]).

countSubstrings(S, C, C) ->
    count_substrings(S, C, 0, 0).

count_substrings([], _, Count, _) ->
    Count;
count_substrings([H | T], C, Count, CurrentCount) ->
    NewCount = if H =:= C -> CurrentCount + 1; true -> 0 end,
    count_substrings(T, C, Count + NewCount, NewCount).