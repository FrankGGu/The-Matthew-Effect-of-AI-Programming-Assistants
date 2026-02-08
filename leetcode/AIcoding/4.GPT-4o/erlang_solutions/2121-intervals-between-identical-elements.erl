-module(solution).
-export([get_intervals/1]).

get_intervals(List) ->
    get_intervals(List, [], #{}, 0).

get_intervals([], Acc, _, _) ->
    lists:reverse(Acc);
get_intervals([H | T], Acc, Map, Index) ->
    NewIndex = Index + 1,
    case maps:is_key(H, Map) of
        true ->
            LastIndex = maps:get(H, Map),
            NewAcc = [{H, NewIndex - LastIndex - 1} | Acc],
            NewMap = maps:put(H, NewIndex, Map);
        false ->
            NewAcc = [{H, -1} | Acc],
            NewMap = maps:put(H, NewIndex, Map)
    end,
    get_intervals(T, NewAcc, NewMap, NewIndex).