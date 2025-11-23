-module(di_sequence).
-export([valid_permutations/1]).

valid_permutations(S) ->
    N = length(S),
    DP = array:new(N+1, {default, 0}),
    array:set(0, 1, DP),
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if I == 0 -> ok;
               S =:= "D" -> 
                   array:set(J, array:get(J, DP) + array:get(J-1, DP), DP);
               true -> 
                   array:set(J, array:get(J, DP) + array:get(J-1, DP), DP)
            end
        end, lists:seq(0, I))
    end, lists:seq(1, N)),
    array:get(N, DP).