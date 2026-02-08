-module(solution).
-export([group_anagrams/1]).

group_anagrams(Anagrams) ->
    group_anagrams(Anagrams, #{}).

group_anagrams([], Acc) ->
    lists:sort(
        lists:map(fun({_Key, Value}) -> Value end, maps:to_list(Acc))
    );

group_anagrams([Word | Rest], Acc) ->
    Key = lists:sort(Word),
    case maps:find(Key, Acc) of
        {ok, List} ->
            NewAcc = maps:update(Key, [Word | List], Acc),
            group_anagrams(Rest, NewAcc);
        error ->
            NewAcc = maps:put(Key, [Word], Acc),
            group_anagrams(Rest, NewAcc)
    end.