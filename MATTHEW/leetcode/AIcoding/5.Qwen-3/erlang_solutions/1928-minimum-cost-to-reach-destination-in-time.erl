-module(solution).
-export([minCost/3]).

minCost(Cost, Rides, Time) ->
    N = length(Cost),
    {_, Result} = dijkstra(N, Cost, Rides, Time),
    Result.

dijkstra(N, Cost, Rides, TargetTime) ->
    Adj = build_adj(Rides),
    {_, MinCost} = lists:foldl(
        fun(I, {Dist, _}) ->
            Dist2 = maps:update_with(I, fun(V) -> V end, infinity, Dist),
            {Dist2, 0}
        end,
        {maps:from_list([{I, infinity} || I <- lists:seq(1, N)]), 0},
        lists:seq(1, N)
    ),
    % Start from node 1
    Dist = maps:update(1, 0, maps:from_list([{I, infinity} || I <- lists:seq(1, N)])),
    Queue = queue:from_list([{0, 1}]),
    dijkstra_helper(Dist, Queue, Adj, TargetTime).

dijkstra_helper(Dist, Queue, _, _) when queue:is_empty(Queue) ->
    case maps:get(N, Dist) of
        infinity -> -1;
        Val -> Val
    end;

dijkstra_helper(Dist, Queue, Adj, TargetTime) ->
    {CurrentCost, CurrentNode} = queue:out(Queue),
    case maps:get(CurrentNode, Dist) < CurrentCost of
        true ->
            dijkstra_helper(Dist, Queue, Adj, TargetTime);
        false ->
            NewQueue = queue:from_list(queue:to_list(Queue)),
            lists:foreach(
                fun({To, Time}) ->
                    case maps:get(CurrentNode, Dist) + Time =< TargetTime of
                        true ->
                            NewCost = maps:get(CurrentNode, Dist) + Cost[CurrentNode - 1],
                            if
                                maps:get(To, Dist) > NewCost ->
                                    NewDist = maps:update(To, NewCost, Dist),
                                    NewQueue2 = queue:in({NewCost, To}, NewQueue),
                                    dijkstra_helper(NewDist, NewQueue2, Adj, TargetTime);
                                true ->
                                    ok
                            end;
                        false ->
                            ok
                    end
                end,
                maps:get(CurrentNode, Adj)
            ),
            dijkstra_helper(Dist, NewQueue, Adj, TargetTime)
    end.

build_adj(Rides) ->
    maps:from_list(
        lists:foldl(
            fun({From, To, Time}, Acc) ->
                maps:update_with(
                    From,
                    fun(Val) -> [ {To, Time} | Val ] end,
                    [ {To, Time} ],
                    Acc
                )
            end,
            maps:new(),
            Rides
        )
    ).