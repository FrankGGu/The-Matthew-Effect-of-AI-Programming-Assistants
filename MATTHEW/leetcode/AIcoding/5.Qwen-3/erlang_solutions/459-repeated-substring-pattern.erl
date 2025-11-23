-module(repeated_substring_pattern).
-export([repeated_substring_pattern/1]).

repeated_substring_pattern(S) ->
    Len = length(S),
    lists:member(S, [lists:sublist(S, I) || I <- lists:seq(1, Len-1), Len rem I == 0, lists:flatten([lists:sublist(S, I) || _ <- lists:seq(1, Len div I)]) == S]).