-module(solution).
-export([count_pairs/1]).

count_pairs(Numbers) ->
    count_pairs(Numbers, 0, maps:new()).

count_pairs([], Count, _) ->
    Count;
count_pairs([N | Rest], Count, Map) ->
    Current = maps:get(N, Map, 0),
    NewCount = Count + Current,
    NewMap = maps:put(N, Current + 1, Map),
    count_pairs(Rest, NewCount, NewMap).