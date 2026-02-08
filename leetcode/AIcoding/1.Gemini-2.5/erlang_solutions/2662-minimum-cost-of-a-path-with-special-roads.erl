-module(solution).
-export([minimumCost/3]).

minimumCost(TargetX, TargetY, SpecialRoads) ->
    Target = {TargetX, TargetY},
    Start = {0,0},

    % Collect all unique points involved in the graph
    AllPointsList = [{0,0}, Target],
    AllPointsList1 = lists:foldl(fun([X1,Y1,X2,Y2,_], Acc) -> [{X1,Y1}, {X2,Y2} | Acc] end, AllPointsList, SpecialRoads),
    AllPoints = ordsets:from_list(AllPointsList1), % Ensure unique points, sorted for consistent iteration

    % Pre-process special roads into a map for O(logN) lookup
    % Key: {{FromX,FromY}, {ToX,ToY}}, Value: Cost
    % If multiple special roads exist between the same two points, take the minimum cost.
    SpecialRoadMap = lists:foldl(fun([X1,Y1,X2,Y2,Cost], Acc) ->
        FromTo = {{X1,Y1}, {X2,Y2}},
        CurrentCost = gb_trees:get(FromTo, Acc, infinity()),
        gb_trees:insert(FromTo, min(CurrentCost, Cost), Acc)
    end, gb_trees:empty(), SpecialRoads),

    % Distances map: Point -> Minimum cost to reach that point from Start
    Distances = gb_trees:insert(Start, 0, gb_trees:empty()),

    % Priority Queue: Cost -> List of Points that can be reached with that cost
    % Using gb_trees where keys are costs (priorities) and values are lists of points.
    PQ = gb_trees:insert(0, [Start], gb_trees:empty()),

    dijkstra(PQ, Distances, Target, AllPoints, SpecialRoadMap).

dijkstra(PQ, Distances, Target, AllPoints, SpecialRoadMap) ->
    if gb_trees:is_empty(PQ) ->
        % If PQ is empty, all reachable nodes have been processed.
        % Return the cost to target, or infinity if unreachable.
        gb_trees:get(Target, Distances, infinity());
    else
        % Extract the point(s) with the minimum cost from the priority queue
        {MinCost, PointsAtMinCost} = gb_trees:take_min(PQ),
        PQ1 = gb_trees:delete_min(PQ),

        [CurrentPoint | RestPoints] = PointsAtMinCost,

        % Check if CurrentPoint has already been processed with a lower cost.
        % This handles cases where a point is added to the PQ multiple times with different costs,
        % and we only want to process it with its true minimum cost found so far.
        CurrentPointKnownMinCost = gb_trees:get(CurrentPoint, Distances, infinity()),
        if CurrentPointKnownMinCost < MinCost ->
            % A shorter path to CurrentPoint was already found and processed. Skip this entry.
            % Re-insert any other points that were at the same MinCost.
            PQ_next = if RestPoints == [] -> PQ1; true -> gb_trees:insert(MinCost, RestPoints, PQ1) end,
            dijkstra(PQ_next, Distances, Target, AllPoints, SpecialRoadMap);
        when CurrentPoint == Target ->
            % If the target is the current point, we've found the shortest path to it.
            MinCost;
        else
            % Process CurrentPoint
            % Re-insert any other points that were at the same MinCost.
            PQ_after_current_point = if RestPoints == [] -> PQ1; true -> gb_trees:insert(MinCost, RestPoints, PQ1) end,

            % Explore neighbors of CurrentPoint
            {NewPQ, NewDistances} = lists:foldl(fun(NeighborPoint, {AccPQ, AccDist}) ->
                if NeighborPoint == CurrentPoint ->
                    % Skip self-loop
                    {AccPQ, AccDist};
                else
                    CurrentPointX = element(1, CurrentPoint),
                    CurrentPointY = element(2, CurrentPoint),
                    NeighborPointX = element(1, NeighborPoint),
                    NeighborPointY = element(2, NeighborPoint),

                    % Calculate normal travel cost (Manhattan distance)
                    NormalCost = abs(CurrentPointX - NeighborPointX) + abs(CurrentPointY - NeighborPointY),

                    % Check for special road cost from CurrentPoint to NeighborPoint
                    SpecialRoadCost = gb_trees:get({{CurrentPoint, NeighborPoint}}, SpecialRoadMap, infinity()),

                    % The actual edge cost is the minimum of normal travel and any special road
                    EdgeCost = min(NormalCost, SpecialRoadCost),

                    PathCost = MinCost + EdgeCost,

                    % Get the currently known minimum distance to NeighborPoint
                    ExistingDist = gb_trees:get(NeighborPoint, AccDist, infinity()),

                    if PathCost < ExistingDist ->
                        % If a shorter path to NeighborPoint is found, update distances and PQ
                        AccDist1 = gb_trees:insert(NeighborPoint, PathCost, AccDist),
                        PointsAtPathCost = gb_trees:get(PathCost, AccPQ, []),
                        AccPQ1 = gb_trees:insert(PathCost, [NeighborPoint | PointsAtPathCost], AccPQ),
                        {AccPQ1, AccDist1};
                    else
                        % No improvement, keep current state
                        {AccPQ, AccDist}
                    end
                end
            end, {PQ_after_current_point, Distances}, AllPoints),

            % Recurse with the updated priority queue and distances
            dijkstra(NewPQ, NewDistances, Target, AllPoints, SpecialRoadMap)
    end.

infinity() -> 1_000_000_000.

abs(N) when N < 0 -> -N;
abs(N) -> N.