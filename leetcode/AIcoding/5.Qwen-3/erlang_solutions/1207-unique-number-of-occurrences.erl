-module(unique_number_of_occurrences).
-export([unique_occurrences/1]).

unique_occurrences(Numbers) ->
    CountMap = count_occurrences(Numbers, #{}),
    Values = maps:values(CountMap),
    lists:all(fun(X) -> lists:member(X, Values) end, Values).

count_occurrences([], Map) ->
    Map;
count_occurrences([H | T], Map) ->
    Count = maps:get(H, Map, 0),
    NewMap = maps:put(H, Count + 1, Map),
    count_occurrences(T, NewMap).