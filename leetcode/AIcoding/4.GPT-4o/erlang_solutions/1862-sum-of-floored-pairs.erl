-module(solution).
-export([sum_floored_pairs/1]).

sum_floored_pairs(Numbers) ->
    Max = lists:max(Numbers),
    Count = lists:duplicate(Max + 1, 0),
    lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(I, Acc1) -> 
            Acc1 + 1 
        end, Acc, lists:seq(1, Max div X)) 
    end, Count, Numbers),
    lists:foldl(fun(X, Acc) -> 
        Acc + lists:nth(X + 1, Count) * X 
    end, 0, lists:seq(0, Max)).