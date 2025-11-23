-module(solution).
-export([group_anagrams/1]).

group_anagrams(Strs) ->
    lists:foldl(fun(Str, Acc) ->
        Key = lists:sort(lists:to_list(Str)),
        Map = maps:find(Key, Acc, []),
        case Map of
            [] -> maps:put(Key, [Str], Acc);
            _  -> Acc1 = maps:update(Key, fun(L) -> [Str | L] end, Acc),
                  Acc1
        end
    end, maps:new(), Strs).