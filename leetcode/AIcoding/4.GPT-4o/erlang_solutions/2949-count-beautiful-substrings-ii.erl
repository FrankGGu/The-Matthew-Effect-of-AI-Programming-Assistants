-module(solution).
-export([count_beautiful_substrings/2]).

count_beautiful_substrings(S, K) ->
    count_beautiful_substrings(S, K, 0, 0).

count_beautiful_substrings([], _, Count, _) ->
    Count;
count_beautiful_substrings([H | T], K, Count, Consecutive) ->
    NewConsecutive = if H == $1 -> Consecutive + 1; true -> 0 end,
    NewCount = if NewConsecutive >= K -> Count + 1; true -> Count end,
    count_beautiful_substrings(T, K, NewCount, NewConsecutive).