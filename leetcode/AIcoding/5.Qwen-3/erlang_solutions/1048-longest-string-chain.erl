-module(longest_string_chain).
-export([longestStrChain/1]).

longestStrChain(Words) ->
    Sorted = lists:sort(Words, fun(A, B) -> length(A) < length(B) end),
    Map = maps:from_list([{Word, 1} || Word <- Sorted]),
    lists:foldl(fun(Word, Acc) ->
        lists:foreach(fun(Prefix) ->
            case maps:is_key(Prefix, Map) of
                true ->
                    maps:update(Word, maps:get(Word, Map) + maps:get(Prefix, Map), Acc);
                false ->
                    ok
            end
        end, [lists:sublist(Word, N) || N <- lists:seq(1, length(Word)-1)]),
        Acc
    end, Map, Sorted),
    lists:max(maps:values(Map)).

longestStrChain(_) ->
    0.