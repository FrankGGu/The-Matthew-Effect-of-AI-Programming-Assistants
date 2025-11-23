-module(solution).
-export([longest_repeating_substring/1]).

longest_repeating_substring(Str) ->
    longest_repeating_substring(Str, 0, 0, 0).

longest_repeating_substring([], CurrentCount, MaxCount, _) ->
    MaxCount;
longest_repeating_substring([H|T], CurrentCount, MaxCount, LastChar) when H =:= LastChar ->
    longest_repeating_substring(T, CurrentCount + 1, MaxCount, LastChar);
longest_repeating_substring([H|T], CurrentCount, MaxCount, LastChar) ->
    longest_repeating_substring(T, 1, max(CurrentCount, MaxCount), H).