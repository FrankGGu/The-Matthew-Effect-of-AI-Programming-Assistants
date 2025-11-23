-module(solution).
-export([chaseGame/2]).

bfs(StartNode, N, Adj) ->
    Distances0 = array:new([{size, N + 1}, {fixed, true}, {default, -1}]),
    Distances1 = array:set(StartNode, 0, Distances0),
    Queue0 = queue:from_list([{StartNode, 0}]),
    bfs_loop(Queue0, Distances1, Adj).

bfs_loop(Queue, Distances, Adj) ->
    case queue:out(Queue) of
        {{value, {U, D}}, RestQueue} ->
            Neighbors = array:get(U, Adj),
            {NewQueue, NewDistances} = lists:foldl(fun(V, {AccQ, AccDist}) ->
                                                       case array:get(V, AccDist) of
                                                           -1 ->
                                                               {queue:in({V, D + 1}, AccQ), array:set(V, D + 1, AccDist)};
                                                           _ -> {AccQ, AccDist}
                                                       end
                                                   end, {RestQueue, Distances}, Neighbors),
            bfs_loop(NewQueue, NewDistances, Adj);
        {empty, _} ->
            Distances
    end.

chaseGame(Edges, A, B) ->
    N = length(Edges) + 1,

    Adj0 = array:new([{size, N + 1}, {fixed, true}, {default, []}]),
    Adj = lists:foldl(fun([U, V], AccAdj) ->
                              AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
                              array:set(V, [U | array:get(V, AccAdj1)], AccAdj1)
                      end, Adj0, Edges),

    Da = bfs(A, N, Adj),
    Db = bfs(B, N, Adj),

    MaxBobEscapeTimePlusOne = lists:foldl(fun(I, AccMax) ->
                                              DaI = array:get(I, Da),
                                              DbI = array:get(I, Db),
                                              if
                                                  DaI > DbI ->
                                                      max(AccMax, DbI + 1);
                                                  true ->
                                                      AccMax
                                              end
                                          end, -1, lists:seq(1, N)),

    if
        MaxBobEscapeTimePlusOne == -1 ->
            (array:get(B, Da) + 1) div 2;
        true ->
            max((array:get(B, Da) + 1) div 2, MaxBobEscapeTimePlusOne)
    end.