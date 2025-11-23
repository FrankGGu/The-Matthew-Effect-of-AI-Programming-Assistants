-module(solution).
-export([maximal_network_rank/2]).

maximal_network_rank(N, roads) ->
    AdjacencyList = lists:foldl(fun({A, B}, Acc) ->
        maps:update(A, [B | maps:get(A, Acc, [])], Acc)
    end, maps:new(), roads),
    MaxRank = lists:max(
        [lists:sum([if 
            lists:member(B, maps:get(A, AdjacencyList, [])) -> 0; 
            true -> 1 
        end || B <- maps:keys(AdjacencyList)]) 
        || A <- maps:keys(AdjacencyList)])
    ),
    MaxRank.