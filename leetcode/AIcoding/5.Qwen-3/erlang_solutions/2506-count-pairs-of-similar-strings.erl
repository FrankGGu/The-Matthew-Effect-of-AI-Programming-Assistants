-module(solution).
-export([num_similar_pairs/1]).

num_similar_pairs(Strings) ->
    Count = maps:from_list([{S, 0} || S <- Strings]),
    lists:foldl(fun(S, Acc) -> maps:update_with(S, fun(V) -> V + 1 end, Acc) end, Count, Strings),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1) div 2) end, 0, Count).