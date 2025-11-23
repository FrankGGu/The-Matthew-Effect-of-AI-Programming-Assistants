-module(solution).
-export([group_anagrams/1]).

group_anagrams(Strs) ->
    lists:foldl(
        fun(Str, AccMap) ->
            Key = lists:sort(Str),
            CurrentGroup = maps:get(Key, AccMap, []),
            maps:put(Key, [Str | CurrentGroup], AccMap)
        end,
        maps:new(),
        Strs
    ) |> maps:values().