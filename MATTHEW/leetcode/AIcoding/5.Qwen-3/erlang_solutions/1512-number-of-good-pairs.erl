-module(num_good_pairs).
-export([num_good_pairs/1]).

num_good_pairs(Numbers) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Numbers),
    maps:fold(fun(_, V, Sum) -> Sum + (V * (V - 1) div 2) end, 0, Count).