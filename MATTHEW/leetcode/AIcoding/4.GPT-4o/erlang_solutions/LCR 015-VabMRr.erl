-module(solution).
-export([find_anagrams/2]).

find_anagrams(S, P) ->
    P_len = string:length(P),
    S_len = string:length(S),
    P_sorted = lists:sort(string:to_lower(P)),
    find_anagrams_helper(S, S_len, P_len, P_sorted, []).

find_anagrams_helper(_, S_len, P_len, _, Result) when S_len < P_len ->
    lists:reverse(Result);
find_anagrams_helper(S, S_len, P_len, P_sorted, Result) ->
    Substring = string:substr(S, 1, P_len),
    Substring_sorted = lists:sort(string:to_lower(Substring)),
    NewResult = if
        Substring_sorted =:= P_sorted -> 
            [1 | Result];
        true -> 
            Result
    end,
    find_anagrams_helper(string:substr(S, 2, S_len - 1), S_len - 1, P_len, P_sorted, NewResult).