-module(solution).
-export([max_ways/1]).

max_ways(Nums) ->
    Total = lists:sum(Nums),
    Half = Total div 2,
    N = length(Nums),
    Ways = lists:duplicate(Half + 1, 0),
    Ways ! 0,
    Ways ! 0,
    lists:foldl(fun(X, Acc) ->
        lists:foldr(fun(J, Acc2) ->
            if
                J >= X -> 
                    Acc2 ++ [lists:nth(J - X + 1, Acc2) + lists:nth(J, Acc2)]
                ;
                true -> 
                    Acc2 ++ [lists:nth(J, Acc2)]
            end
        end, [], lists:seq(0, Half))
    end, Ways, Nums),
    lists:last(Ways).