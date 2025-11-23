-module(solution).
-export([find_longest_special_substring/1]).

find_longest_special_substring(S) ->
    Length = string:length(S),
    MaxLength = 0,
    SpecialString = false,
    find_longest(S, Length, MaxLength, SpecialString).

find_longest(S, Length, MaxLength, SpecialString) ->
    case Length of
        0 -> MaxLength;
        _ ->
            SubStrs = find_substrings(S, Length),
            lists:foldl(fun(SubStr, Acc) ->
                if 
                    check_occurrences(S, SubStr) =:= 3 -> 
                        Max = lists:max([MaxLength, string:length(SubStr)]),
                        find_longest(S, Length - 1, Max, true);
                    true -> 
                        find_longest(S, Length - 1, MaxLength, SpecialString)
                end
            end, MaxLength, SubStrs)
    end.

find_substrings(S, Length) ->
    lists:map(fun(I) -> string:substring(S, I, Length) end, lists:seq(1, string:length(S) - Length + 1)).

check_occurrences(S, SubStr) ->
    count_occurrences(S, SubStr, 0).

count_occurrences([], _, Count) -> Count;
count_occurrences(Str, SubStr, Count) ->
    case string:find(Str, SubStr) of
        none -> Count;
        {ok, Index} ->
            count_occurrences(string:substring(Str, Index + 1), SubStr, Count + 1)
    end.