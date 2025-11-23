-module(solution).
-export([countPairs/2]).

countPairs(A, k) ->
    Count = lists:foldl(fun(X, Acc) -> 
        NewCounts = lists:map(fun(Y) -> rem(X + Y, k) end, A),
        Acc ++ NewCounts 
    end, [], A),
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, A) of 
            true -> Acc + 1; 
            false -> Acc 
        end 
    end, 0, Count) div 2.