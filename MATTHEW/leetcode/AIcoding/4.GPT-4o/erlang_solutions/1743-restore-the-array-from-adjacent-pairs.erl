-module(solution).

-export([restore_array/1]).

restore_array(Pairs) ->
    Map = lists:foldl(fun({A, B}, Acc) ->
        maps:update_with(A, fun(X) -> [B | X] end, [B], Acc)
    end, map:new(), Pairs),
    Start = lists:find(fun({K, _}) -> maps:size(maps:get(K, Map)) == 1 end, maps:to_list(Map)),
    restore(Start, Map, []).

restore({K, _}, Map, Visited) ->
    case lists:member(K, Visited) of
        true -> lists:reverse(Visited);
        false ->
            Neighbors = maps:get(K, Map),
            lists:foldl(fun(N, Acc) -> restore(N, Map, [K | Acc] ) end, Visited, Neighbors)
    end.