-module(solution).
-export([secondMinimumTime/4]).

-define(INFINITY, 1_000_000_000_000_000). % Sufficiently large for max time ~3*10^7

build_adj_list(N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(List) -> [V|List] end, [V], Acc),
            maps:update_with(V, fun(List) -> [U|List] end, [U], Acc1)
        end,
        maps:new(),
        Edges
    ).

add_to_pq(Time, Node, PQ) ->
    gb_trees:update_in(Time, fun(Nodes) -> [Node | Nodes] end, [Node], PQ).

take_smallest_from_pq(PQ) ->
    case gb_trees:is_empty(PQ) of
        true -> {empty, PQ};
        false ->
            {{SmallestTime, Nodes}, TempPQ} = gb_trees:take_smallest(PQ),
            [CurrentNode | RestNodes] = Nodes,
            NewPQ = case RestNodes of
                        [] -> TempPQ;
                        _ -> gb_trees:insert(SmallestTime, RestNodes, TempPQ)
                    end,
            {{SmallestTime, CurrentNode}, NewPQ}
    end.

get_departure_time(CurrentTime, Change) ->
    CycleLength = 2 * Change,
    TimeInCurrentCycle = CurrentTime rem CycleLength,
    GreenLightDuration = Change,

    if TimeInCurrentCycle < GreenLightDuration ->
        CurrentTime; % Currently green, depart immediately
    true ->
        % Currently red, wait until the next green light starts
        CurrentTime + (CycleLength - TimeInCurrentCycle)
    end.

secondMinimumTime(N, Edges, Time, Change) ->
    Adj = build_adj_list(N, Edges),

    % MinTimes stores {Min1, Min2} for each node
    MinTimes = array:new({size, N + 1, default, {?INFINITY, ?INFINITY}}),
    MinTimes1 = array:set(1, {0, ?INFINITY}, MinTimes), % Start node 1 has min time 0

    PQ = add_to_pq(0, 1, gb_trees:empty()), % Initialize PQ with {0, 1}

    bfs(N, Adj, Time, Change, MinTimes1, PQ).

bfs(TargetNode, Adj, EdgeTime, Change, MinTimes, PQ) ->
    case take_smallest_from_pq(PQ) of
        {empty, _} ->
            % PQ is empty, all reachable nodes processed
            element(2, array:get(TargetNode, MinTimes));
        {{CurrentTime, CurrentNode}, NewPQ} ->
            {Min1, Min2} = array:get(CurrentNode, MinTimes),

            % Pruning: if CurrentTime is already greater than the second minimum
            % recorded for CurrentNode, this path won't lead to a new second minimum.
            % We only process if CurrentTime is strictly less than Min2.
            % If CurrentTime == Min1 or CurrentTime == Min2, we process it.
            % If CurrentTime > Min2, we skip.
            case CurrentTime > Min2 of
                true ->
                    bfs(TargetNode, Adj, EdgeTime, Change, MinTimes, NewPQ);
                false ->
                    DepartureTime = get_departure_time(CurrentTime, Change),
                    ArrivalTime = DepartureTime + EdgeTime,

                    Neighbors = maps:get(CurrentNode, Adj, []), % Get neighbors of CurrentNode

                    {UpdatedMinTimes, UpdatedPQ} = lists:foldl(
                        fun(Neighbor, {AccMinTimes, AccPQ}) ->
                            {NeighborMin1, NeighborMin2} = array:get(Neighbor, AccMinTimes),

                            if ArrivalTime < NeighborMin1 ->
                                % Found a new minimum path to Neighbor
                                NewAccMinTimes = array:set(Neighbor, {ArrivalTime, NeighborMin1}, AccMinTimes),
                                NewAccPQ = add_to_pq(ArrivalTime, Neighbor, AccPQ),
                                {NewAccMinTimes, NewAccPQ};
                            ArrivalTime > NeighborMin1 andalso ArrivalTime < NeighborMin2 ->
                                % Found a new second minimum path to Neighbor
                                NewAccMinTimes = array:set(Neighbor, {NeighborMin1, ArrivalTime}, AccMinTimes),
                                NewAccPQ = add_to_pq(ArrivalTime, Neighbor, AccPQ),
                                {NewAccMinTimes, NewAccPQ};
                            true ->
                                % Path is either equal to Min1/Min2 or worse than Min2, no update needed
                                {AccMinTimes, AccPQ}
                            end
                        end,
                        {MinTimes, NewPQ},
                        Neighbors
                    ),
                    bfs(TargetNode, Adj, EdgeTime, Change, UpdatedMinTimes, UpdatedPQ)
            end
    end.