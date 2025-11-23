-module(solution).
-export([find_duplicates/1]).

find_duplicates(Numbers) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of 
            true -> lists:delete(X, Acc); 
            false -> [X | Acc] 
        end 
    end, [], Numbers).