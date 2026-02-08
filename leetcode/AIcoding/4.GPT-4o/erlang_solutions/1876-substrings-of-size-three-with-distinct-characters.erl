-module(solution).
-export([count_good_substrings/1]).

count_good_substrings(S) ->
    count_good_substrings(S, length(S), 0).

count_good_substrings(S, Len, Count) when Len < 3 ->
    Count;

count_good_substrings(S, Len, Count) ->
    Substring = string:substr(S, Len - 2, 3),
    Distinct = lists:usort(string:to_list(Substring)),
    NewCount = if
        length(Distinct) == 3 -> Count + 1;
        true -> Count
    end,
    count_good_substrings(S, Len - 1, NewCount).