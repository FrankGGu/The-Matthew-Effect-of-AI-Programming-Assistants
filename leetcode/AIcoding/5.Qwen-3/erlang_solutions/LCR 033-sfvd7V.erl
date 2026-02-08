-module(anagrams_group).
-export([group_anagrams/1]).

group_anagrams([]) -> [];
group_anagrams([H | T]) ->
    lists:foldl(fun(Word, Acc) ->
        Key = lists:sort(Word),
        case lists:keyfind(Key, 1, Acc) of
            false ->
                [{Key, [Word]} | Acc];
            {Key, Words} ->
                lists:keystore(Key, 1, Acc, {Key, [Word | Words]})
        end
    end, [], [H | T]) ++ [].

group_anagrams([]) -> [];
group_anagrams(List) ->
    group_anagrams(List, #{}).

group_anagrams([], Map) ->
    maps:values(Map);
group_anagrams([Word | Rest], Map) ->
    Key = lists:sort(Word),
    case maps:is_key(Key, Map) of
        true ->
            NewMap = maps:update(Key, [Word | maps:get(Key, Map)], Map),
            group_anagrams(Rest, NewMap);
        false ->
            NewMap = maps:put(Key, [Word], Map),
            group_anagrams(Rest, NewMap)
    end.