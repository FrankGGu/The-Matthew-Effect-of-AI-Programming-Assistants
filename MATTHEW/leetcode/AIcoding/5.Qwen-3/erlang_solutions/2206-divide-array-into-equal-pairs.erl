-module(divide_array_into_equal_pairs).
-export([can_divide/1]).

can_divide(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    lists:all(fun({_, V}) -> V rem 2 == 0 end, maps:to_list(Count)).