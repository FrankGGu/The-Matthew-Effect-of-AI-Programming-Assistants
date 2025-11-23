-module(solution).
-export([countAlmostEqualPairs/1]).

countAlmostEqualPairs(List) ->
    Counts = lists:foldl(fun(X, Acc) ->
        Map = maps:update_with(X, fun(V) -> V + 1 end, 1, Acc),
        Map
    end, maps:empty(), List),
    lists:foldl(fun({K, V}, Acc) ->
        Acc + (V * (V - 1)) div 2
    end, 0, maps:to_list(Counts)).