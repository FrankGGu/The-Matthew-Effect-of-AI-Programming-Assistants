-module(solution).
-export([group_anagrams/1]).

group_anagrams(Strings) ->
    GroupedMap = lists:foldl(
        fun(Str, AccMap) ->
            SortedStr = lists:sort(Str),
            case maps:find(SortedStr, AccMap) of
                {ok, AnagramList} ->
                    maps:put(SortedStr, [Str | AnagramList], AccMap);
                error ->
                    maps:put(SortedStr, [Str], AccMap)
            end
        end,
        #{},
        Strings
    ),
    maps:values(GroupedMap).