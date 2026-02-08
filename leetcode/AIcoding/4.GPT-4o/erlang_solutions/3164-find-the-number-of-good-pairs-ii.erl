-module(solution).
-export([count_good_pairs/1]).

count_good_pairs(Nums) ->
    Count = lists:foldl(fun(X, Acc) -> 
        NewMap = maps:update_with(X, fun(V) -> V + 1 end, 1, Acc),
        maps:fold(fun(_, V, Acc2) -> Acc2 + V * (V - 1) div 2 end, Acc, NewMap)
    end, maps:new(), Nums),
    maps:fold(fun(_, V, Acc) -> Acc + V * (V - 1) div 2 end, 0, Count).