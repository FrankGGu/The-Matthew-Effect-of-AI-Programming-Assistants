-module(solution).
-export([minCostConnectPoints/1]).

-define(INFINITY, 16#7FFFFFFF). % Max 32-bit signed integer value for infinity

minCostConnectPoints(Points) ->
    N = length(Points),
    case N of
        0 -> 0;
        1 -> 0;
        _ ->
            PointsArray = array:from_list(Points),

            % MinDists[i] stores the minimum distance from point i to any point already in the MST
            % Initialize all to infinity. Point 0 is chosen as the starting point, its distance to MST is 0.
            MinDists = array:new(N, {default, ?INFINITY}),
            MinDists_0 = array:set(0, 0, MinDists),

            % Visited[i] is true if point i is already in the MST
            Visited = array:new(N, {default, false}),

            % Start Prim's algorithm.
            % We start with 1 point in MST (point 0), and 0 accumulated cost.
            prim_loop(N, PointsArray, MinDists_0, Visited, 1, 0)
    end.

prim_loop(N, PointsArray, MinDists, Visited, PointsInMSTCount, CurrentTotalCost) ->
    if
        PointsInMSTCount == N -> % All N points are in the MST
            CurrentTotalCost;
        true ->
            % Find the unvisited point with the minimum distance to the MST
            {MinDistVal, NextPointIdx} = find_min_unvisited(N, MinDists, Visited),

            % This case should not be reached for a connected graph with N > 0 points
            % as there will always be an unvisited point until all are added.
            if
                NextPointIdx == -1 ->
                    CurrentTotalCost;
                true ->
                    % Mark the found point as visited
                    NewVisited = array:set(NextPointIdx, true, Visited),

                    % Add its minimum distance to the total cost
                    NewTotalCost = CurrentTotalCost + MinDistVal,

                    % Update distances for neighbors of the newly added point
                    NewMinDists = update_min_dists(N, PointsArray, MinDists, NewVisited, NextPointIdx),

                    % Recurse for the next point to add
                    prim_loop(N, PointsArray, NewMinDists, NewVisited, PointsInMSTCount + 1, NewTotalCost)
            end
    end.

find_min_unvisited(N, MinDists, Visited) ->
    find_min_unvisited_loop(N, MinDists, Visited, 0, ?INFINITY, -1).

find_min_unvisited_loop(N, MinDists, Visited, Idx, CurrentMinVal, CurrentMinIdx) ->
    if
        Idx == N ->
            {CurrentMinVal, CurrentMinIdx};
        true ->
            case array:get(Idx, Visited) of
                true -> % Point already visited, skip
                    find_min_unvisited_loop(N, MinDists, Visited, Idx + 1, CurrentMinVal, CurrentMinIdx);
                false -> % Point not visited
                    Dist = array:get(Idx, MinDists),
                    if
                        Dist < CurrentMinVal ->
                            find_min_unvisited_loop(N, MinDists, Visited, Idx + 1, Dist, Idx);
                        true ->
                            find_min_unvisited_loop(N, MinDists, Visited, Idx + 1, CurrentMinVal, CurrentMinIdx)
                    end
            end
    end.

update_min_dists(N, PointsArray, MinDists, Visited, CurrentPointIdx) ->
    P1 = array:get(CurrentPointIdx, PointsArray),
    X1 = element(1, P1),
    Y1 = element(2, P1),
    update_min_dists_loop(N, PointsArray, MinDists, Visited, X1, Y1, 0).

update_min_dists_loop(N, PointsArray, AccMinDists, Visited, X1, Y1, Idx) ->
    if
        Idx == N ->
            AccMinDists;
        true ->
            case array:get(Idx, Visited) of
                true -> % Point already visited, skip
                    update_min_dists_loop(N, PointsArray, AccMinDists, Visited, X1, Y1, Idx + 1);
                false -> % Point not visited
                    P2 = array:get(Idx, PointsArray),
                    X2 = element(1, P2),
                    Y2 = element(2, P2),
                    ManhattanDist = abs(X1 - X2) + abs(Y1 - Y2),
                    CurrentMinDistForIdx = array:get(Idx, AccMinDists),
                    NewMinDistForIdx = min(CurrentMinDistForIdx, ManhattanDist),
                    NewAccMinDists = array:set(Idx, NewMinDistForIdx, AccMinDists),
                    update_min_dists_loop(N, PointsArray, NewAccMinDists, Visited, X1, Y1, Idx + 1)
            end
    end.