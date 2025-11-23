-module(solution).
-export([most_common_response/1]).

most_common_response(Responses) ->
    Counts = count_responses(Responses, #{}),
    lists:reverse(lists:keysort(1, maps:to_list(Counts))).

count_responses([], Acc) ->
    Acc;
count_responses([H | T], Acc) ->
    Count = maps:get(H, Acc, 0),
    count_responses(T, maps:put(H, Count + 1, Acc)).