-module(solution).
-export([minCostConnectPoints/1]).

-define(INFINITY, 1_000_000_000_000). % A sufficiently large number for infinity

manhattan_distance({X1, Y1}, {X2, Y2}) ->
    abs(X1 - X2) + abs(Y1 - Y2).

minCostConnectPoints(PositionsList) ->
    N = length(PositionsList),

    if N =< 1 ->
        0;
    true ->
        PositionsArray = array:from_list([ {X, Y} || [X, Y] <- PositionsList ]),

        Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
        MinDist = array:new([{size, N}, {fixed, true}, {default, ?INFINITY}]),

        MinDist1 = array:set(0, 0, MinDist),

        prim_loop(0, N, PositionsArray, Visited, MinDist1, 0)
    end.

prim_loop(Count, N, PositionsArray, Visited, MinDist, CurrentTotalCost) ->
    if Count == N ->
        CurrentTotalCost;
    true ->
        {U, MinEdge} = find_min_edge_point(N, Visited, MinDist),

        if U == -1 ->
            CurrentTotalCost;
        true ->
            Visited1 = array:set(U, true, Visited),
            TotalCost1 = CurrentTotalCost + MinEdge,

            PointU = array:get(U, PositionsArray),

            MinDist2 = update_min_distances(0, N, PointU, PositionsArray, Visited1, MinDist),

            prim_loop(Count + 1, N, PositionsArray, Visited1, MinDist2, TotalCost1)
        end
    end.

find_min_edge_point(N, Visited, MinDist) ->
    find_min_edge_point_iter(0, N, Visited, MinDist, -1, ?INFINITY).

find_min_edge_point_iter(I, N, Visited, MinDist, CurrentU, CurrentMinEdge) ->
    if I == N ->
        {CurrentU, CurrentMinEdge};
    true ->
        IsVisited = array:get(I, Visited),
        if not IsVisited ->
            Dist = array:get(I, MinDist),
            if Dist < CurrentMinEdge ->
                find_min_edge_point_iter(I + 1, N, Visited, MinDist, I, Dist);
            true ->
                find_min_edge_point_iter(I + 1, N, Visited, MinDist, CurrentU, CurrentMinEdge)
            end;
        true ->
            find_min_edge_point_iter(I + 1, N, Visited, MinDist, CurrentU, CurrentMinEdge)
        end
    end.

update_min_distances(V, N, PointU, PositionsArray, Visited, MinDist) ->
    if V == N ->
        MinDist;
    true ->
        IsVisited = array:get(V, Visited),
        if not IsVisited ->
            PointV = array:get(V, PositionsArray),
            DistUV = manhattan_distance(PointU, PointV),
            CurrentMinDistV = array:get(V, MinDist),
            if DistUV < CurrentMinDistV ->
                MinDist1 = array:set(V, DistUV, MinDist),
                update_min_distances(V + 1, N, PointU, PositionsArray, Visited, MinDist1);
            true ->
                update_min_distances(V + 1, N, PointU, PositionsArray, Visited, MinDist)
            end;
        true ->
            update_min_distances(V + 1, N, PointU, PositionsArray, Visited, MinDist)
        end
    end.