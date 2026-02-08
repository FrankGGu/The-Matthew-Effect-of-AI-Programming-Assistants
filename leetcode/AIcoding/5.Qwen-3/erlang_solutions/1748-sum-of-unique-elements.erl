-module(sum_of_unique_elements).
-export([sum_of_unique_elements/1]).

sum_of_unique_elements(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> 
        maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
    end, #{}, Nums),
    lists:foldl(fun({K, V}, Acc) -> 
        if V == 1 -> Acc + K; true -> Acc end 
    end, 0, maps:to_list(Count)).