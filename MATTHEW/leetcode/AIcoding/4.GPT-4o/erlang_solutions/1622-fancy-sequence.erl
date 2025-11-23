-module(solution).
-export([Fancy/1]).

Fancy(N) when N >= 1 ->
    lists:map(fun(X) -> 
        case X rem 3 of 
            0 -> 1;
            1 -> 2;
            2 -> 3
        end
    end, lists:seq(1, N)).