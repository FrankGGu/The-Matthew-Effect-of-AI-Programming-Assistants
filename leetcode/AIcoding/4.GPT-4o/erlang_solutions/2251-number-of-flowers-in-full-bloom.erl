-module(solution).
-export([numFlowersInBloom/2]).

numFlowersInBloom(Flowers, People) ->
    lists:map(fun(P) -> 
        lists:sum(lists:map(fun({L, R}) -> if P >= L andalso P <= R -> 1; true -> 0 end end, Flowers))
    end, People).