-module(solution).
-export([max_energy/2]).

max_energy(N, M) ->
    lists:foldl(fun({E, C}, Acc) -> 
        if 
            Acc + C > N -> 
                Acc 
            ; 
                Acc + E 
        end 
    end, 0, lists:zip(M, lists:seq(1, length(M)))).