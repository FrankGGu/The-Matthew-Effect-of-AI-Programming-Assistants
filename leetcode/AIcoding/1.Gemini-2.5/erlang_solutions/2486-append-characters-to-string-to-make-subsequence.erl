-module(solution).
-export([appendCharacters/2]).

appendCharacters(S, T) ->
    S_len = length(S),
    Found_S_chars = find_subsequence_count(S, T, 0),
    S_len - Found_S_chars.

find_subsequence_count([], _T_list, Current_found_count) ->
    Current_found_count;
find_subsequence_count(_S_list, [], Current_found_count) ->
    Current_found_count;
find_subsequence_count([Sh|St], [Sh|Tt], Current_found_count) ->
    find_subsequence_count(St, Tt, Current_found_count + 1);
find_subsequence_count([Sh|St], [_Th|Tt], Current_found_count) ->
    find_subsequence_count([Sh|St], Tt, Current_found_count).