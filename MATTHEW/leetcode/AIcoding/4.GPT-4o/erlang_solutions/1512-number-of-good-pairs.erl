-module(solution).
-export([numIdenticalPairs/1]).

numIdenticalPairs(List) ->
    CountMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), List),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1)) div 2 end, 0, CountMap).