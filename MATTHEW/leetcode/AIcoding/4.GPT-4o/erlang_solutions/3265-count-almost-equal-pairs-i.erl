-module(solution).
-export([count_almost_equal_pairs/1]).

count_almost_equal_pairs(List) ->
    Count = lists:foldl(fun(X, Acc) -> 
        Acc + lists:foldl(fun(Y, Acc1) -> 
            if 
                abs(X - Y) == 1 -> Acc1 + 1; 
                true -> Acc1 
            end 
        end, Acc, List)
    end, 0, List),
    Count div 2.