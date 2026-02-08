-module(top_k_frequent_elements).
-export([top_k_frequent/2]).

top_k_frequent(Nums, K) ->
    Count = lists:foldl(fun(N, Acc) -> 
        maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
    end, maps:new(), Nums),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A >= B end, maps:to_list(Count)),
    [Key || {Key, _} <- lists:sublist(Sorted, K)].