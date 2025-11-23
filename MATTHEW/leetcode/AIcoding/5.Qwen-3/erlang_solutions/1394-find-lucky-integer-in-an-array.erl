-module(lucky_integer).
-export([find_lucky/1]).

find_lucky(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    lists:foldl(fun({K, V}, Acc) -> if K == V -> {K, V}; true -> Acc end end, none, maps:to_list(Count)).