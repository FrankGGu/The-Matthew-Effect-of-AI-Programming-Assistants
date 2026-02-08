-module(solution).
-export([find_champion/1]).

find_champion(Results) ->
    Teams = lists:usort(lists:flatten(Results)),
    Map = maps:new(),
    lists:foldl(fun([A,B], Acc) ->
        ACount = maps:get(A, Acc, 0),
        BCount = maps:get(B, Acc, 0),
        maps:put(A, ACount + 1, maps:put(B, BCount, Acc))
    end, Map, Results),
    lists:keyfind(2, 2, maps:to_list(Map)).