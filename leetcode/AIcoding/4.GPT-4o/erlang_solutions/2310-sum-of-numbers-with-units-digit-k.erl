-module(solution).
-export([minimum_numbers/2]).

minimum_numbers(S, K) ->
    if
        S == 0 -> 
            if K == 0 -> 1; 
            true -> -1 
            end;
        S rem 10 == K -> 
            S div 10 + 1;
        true -> 
            if 
                S < K -> -1; 
                true -> 
                    minimum_numbers(S - 10, K) 
            end
    end.