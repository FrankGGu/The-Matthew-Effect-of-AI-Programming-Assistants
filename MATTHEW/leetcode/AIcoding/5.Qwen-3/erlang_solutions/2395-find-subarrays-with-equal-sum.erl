-module(solution).
-export([findSubarrays/1]).

findSubarrays(S) ->
    N = length(S),
    Max = N - 2,
    Map = maps:new(),
    findSubarrays(S, 0, Max, Map).

findSubarrays(_, _, Max, _) when Max < 0 ->
    false;
findSubarrays(S, I, Max, Map) ->
    Sum = lists:sum(lists:sublist(S, I + 1, 2)),
    case maps:is_key(Sum, Map) of
        true ->
            true;
        false ->
            NewMap = maps:put(Sum, true, Map),
            findSubarrays(S, I + 1, Max - 1, NewMap)
    end.