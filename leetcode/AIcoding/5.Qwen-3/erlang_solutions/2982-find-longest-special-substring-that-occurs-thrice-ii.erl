-module(solution).
-export([maximum_length/1]).

maximum_length(S) ->
    N = erlang:length(S),
    MaxLen = 0,
    Map = maps:new(),
    % Generate all possible substrings and count their occurrences
    generate_substrings(S, 0, N, Map),
    % Find the maximum length of a substring that occurs at least three times
    find_max_len(Map, 0).

generate_substrings(_, _, N, Map) when N == 0 -> Map;
generate_substrings(S, Start, N, Map) ->
    Sub = string:substr(S, Start + 1, N),
    Count = maps:get(Sub, Map, 0) + 1,
    NewMap = maps:put(Sub, Count, Map),
    generate_substrings(S, Start + 1, N - 1, NewMap).

find_max_len(Map, MaxLen) ->
    lists:foldl(fun({K, V}, Acc) ->
        if V >= 3 -> max(erlang:length(K), Acc);
           true -> Acc
        end
    end, MaxLen, maps:to_list(Map)).