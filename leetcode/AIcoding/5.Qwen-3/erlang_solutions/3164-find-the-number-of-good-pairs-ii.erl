-module(solution).
-export([num_identical_pairs/1]).

num_identical_pairs(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1)) div 2 end, 0, Count).