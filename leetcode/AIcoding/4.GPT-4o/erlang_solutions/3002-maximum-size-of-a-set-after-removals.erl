-module(solution).
-export([maximum_size/1]).

maximum_size(Set) ->
    Max = length(Set),
    lists:foldl(fun(X, Acc) -> 
        if 
            lists:member(X, Acc) -> 
                Acc 
            ; 
            true -> 
                [X | Acc] 
        end 
    end, [], lists:sort(Set)) ++ lists:duplicate(Max - length(Set), 0).