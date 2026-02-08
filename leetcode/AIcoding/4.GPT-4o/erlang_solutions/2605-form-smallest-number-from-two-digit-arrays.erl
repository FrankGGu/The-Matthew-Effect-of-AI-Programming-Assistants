-module(solution).
-export([smallestNumber/2]).

smallestNumber(A, B) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    {MinA, MinB} = {hd(SortedA), hd(SortedB)},
    Smallest = min(MinA, MinB),
    lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc2) -> 
            if 
                X =:= Smallest -> 
                    lists:sort([X | Acc2]);
                Y =:= Smallest -> 
                    lists:sort([Y | Acc2];
                true -> 
                    lists:sort([X, Y | Acc2])
            end 
        end, Acc, SortedB)
    end, [], SortedA).