-module(solution).
-export([countPairs/2]).

countPairs(N, edges) ->
    Graph = lists:foldl(fun({X, Y}, Acc) -> 
        lists:foldl(fun(N, Acc1) -> 
            lists:keystore(N, X, Acc1, {Y, 1}) 
        end, Acc, [Y]) 
    end, lists:duplicate(N, {0, 0}), edges),
    lists:map(fun({_, Count}) -> Count end, Graph).