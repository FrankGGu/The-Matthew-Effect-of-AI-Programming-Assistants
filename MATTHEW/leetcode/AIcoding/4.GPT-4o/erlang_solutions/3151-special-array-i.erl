-module(solution).
-export([special_array/1]).

special_array(Nums) ->
    Max = lists:max(Nums),
    lists:foldl(fun(N, Acc) -> 
        lists:foldl(fun(X, Count) -> 
            if 
                X >= N -> Count + 1; 
                true -> Count 
            end 
        end, 0, Nums) =:= N 
    end, -1, lists:seq(0, Max).