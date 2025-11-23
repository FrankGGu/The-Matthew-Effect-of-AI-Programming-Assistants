-module(solution).
-export([special_array/1]).

special_array(List) ->
    Max = lists:max(List),
    lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(N, C) -> 
            if 
                N >= X -> C + 1; 
                true -> C 
            end 
        end, 0, List) =:= X orelse Acc 
    end, false, lists:seq(0, Max)).