-module(solution).
-export([maximum_subsequence_count/3]).

maximum_subsequence_count(Str, Pat1, Pat2) ->
    Count1 = count_subsequences(Str, Pat1),
    Count2 = count_subsequences(Str, Pat2),
    max(Count1, Count2).

count_subsequences(Str, Pat) ->
    case lists:prefix(Pat, Str) of
        true -> length(lists:sublist(Str, length(Pat))) + 1;
        false -> length(lists:sublist(Str, length(Pat)))
    end.