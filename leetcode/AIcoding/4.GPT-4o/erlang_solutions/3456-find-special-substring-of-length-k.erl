-module(solution).
-export([find_special_substring/2]).

find_special_substring(S, K) ->
    find_special_substring(S, K, length(S), 0).

find_special_substring(_, K, N, Count) when N < K ->
    Count;
find_special_substring(S, K, N, Count) ->
    Substring = lists:sublist(S, K),
    if
        is_special(Substring) ->
            find_special_substring(S, K, N - 1, Count + 1);
        true ->
            find_special_substring(S, K, N - 1, Count)
    end.

is_special(Substring) ->
    UniqueChars = lists:usort(Substring),
    length(UniqueChars) == 1.