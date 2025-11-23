-module(solution).
-export([maximum_good_sum/1]).

maximum_good_sum(Good) ->
    MaxGoodSum = lists:max(lists:filter(fun(X) -> X > 0 end, Good)),
    lists:foldl(fun(X, Acc) -> lists:foldl(fun(Y, Acc2) -> 
        if 
            X + Y > MaxGoodSum -> 
                MaxGoodSum 
            ; 
                Acc2 + X + Y 
        end 
    end, Acc, lists:sublist(Good, 1, length(Good))) 
    end, 0, Good).