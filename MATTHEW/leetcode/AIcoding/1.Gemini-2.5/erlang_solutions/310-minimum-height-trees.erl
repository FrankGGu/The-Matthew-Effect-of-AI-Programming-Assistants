-module(solution).
-export([findMinHeightTrees/2]).

findMinHeightTrees(N, _Edges) when N =< 2 ->
    lists:seq(0, N-1);
findMinHeightTrees(N, Edges) ->
    Adj = maps:from_list([{I, []} || I <- lists:seq(0, N-1)]),
    Degrees = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),

    {FinalAdj, FinalDegrees} = lists:foldl(
        fun([U, V], {CurrentAdj, CurrentDegrees}) ->
            NewAdj1 = maps:update_with(U, fun(L) -> [V|L] end, CurrentAdj),
            NewAdj2 = maps:update_with(V, fun(L) -> [U|L] end, NewAdj1),
            NewDegrees1 = maps:update_with(U, fun(D) -> D+1 end, CurrentDegrees),
            NewDegrees2 = maps:update_with(V, fun(D) -> D+1 end, NewDegrees1),
            {NewAdj2, NewDegrees2}
        end,
        {Adj, Degrees},
        Edges
    ),

    InitialLeaves = lists:filter(
        fun(Node) -> maps:get(Node, FinalDegrees) == 1 end,
        lists:seq(0, N-1)
    ),

    Queue = queue:from_list(InitialLeaves),
    RemainingNodes = N,

    prune_leaves(RemainingNodes, Queue, FinalDegrees, FinalAdj).

prune_leaves(RemainingNodes, Queue, Degrees, Adj) when RemainingNodes =< 2 ->
    queue:to_list(Queue);
prune_leaves(RemainingNodes, Queue, Degrees, Adj) ->
    QueueSize = queue:len(Queue),
    NewRemainingNodes = RemainingNodes - QueueSize,

    {NextQueue, NextDegrees} = process_layer(QueueSize, Queue, Degrees, Adj, queue:new()),

    prune_leaves(NewRemainingNodes, NextQueue, NextDegrees, Adj).

process_layer(0, _CurrentQueue, Degrees, _Adj, AccQueue) ->
    {AccQueue, Degrees};
process_layer(Count, CurrentQueue, Degrees, Adj, AccQueue) ->
    {value, Leaf, TempQueue} = queue:out(CurrentQueue),

    Neighbors = maps:get(Leaf, Adj),

    {UpdatedDegrees, UpdatedAccQueue} = lists:foldl(
        fun(Neighbor, {CDegrees, CAccQueue}) ->
            NewDegree = maps:get(Neighbor, CDegrees) - 1,
            NewCDegrees = maps:put(Neighbor, NewDegree, CDegrees),

            NewCAccQueue = if NewDegree == 1 -> queue:in(Neighbor, CAccQueue);
                              true -> CAccQueue
                           end,
            {NewCDegrees, NewCAccQueue}
        end,
        {Degrees, AccQueue},
        Neighbors
    ),

    process_layer(Count - 1, TempQueue, UpdatedDegrees, Adj, UpdatedAccQueue).