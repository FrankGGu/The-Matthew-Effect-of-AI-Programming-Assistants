-module(solution).
-export([count_substrings/2]).

count_substrings(S, C) ->
    Count = lists:count(C, S),
    Count * (Count + 1) div 2.