-module(solution).
-export([count_beautiful_substrings/1]).

count_beautiful_substrings(S) ->
    count_beautiful_substrings(S, 0, 0).

count_beautiful_substrings([], Count, _) ->
    Count;
count_beautiful_substrings([H | T], Count, Consecutive) ->
    NewCount = if 
        Consecutive > 0 -> Count + 1; 
        true -> Count 
    end,
    NewConsecutive = if 
        H == $1 -> Consecutive + 1; 
        true -> 0 
    end,
    count_beautiful_substrings(T, NewCount, NewConsecutive).