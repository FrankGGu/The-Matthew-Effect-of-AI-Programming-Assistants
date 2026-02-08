-module(minimum_cost_to_reach_every_position).
-export([min_cost_to_reach_every_position/1]).

min_cost_to_reach_every_position(costs) ->
    N = length(costs),
    Dist = lists:duplicate(N, infinity),
    Dist = lists:nth(1, lists:update(1, 0, Dist)),
    PQ = priority_queue:new(),
    PQ1 = priority_queue:insert(1, 0, PQ),
    dijkstra(costs, Dist, PQ1, N).

dijkstra(Costs, Dist, PQ, N) ->
    case priority_queue:is_empty(PQ) of
        true ->
            lists:nth(N, Dist);
        false ->
            {V, D, PQ2} = priority_queue:delete_min(PQ),
            if D > lists:nth(V, Dist) then
                dijkstra(Costs, Dist, PQ2, N)
            else
                Neighbors = get_neighbors(V, N),
                {NewDist, NewPQ} = lists:foldl(
                    fun(Neighbor, {AccDist, AccPQ}) ->
                        Cost = lists:nth(Neighbor, Costs),
                        if lists:nth(V, AccDist) + Cost < lists:nth(Neighbor, AccDist) then
                            NewDist1 = lists:update(Neighbor, lists:nth(V, AccDist) + Cost, AccDist),
                            NewPQ1 = priority_queue:insert(Neighbor, lists:nth(V, AccDist) + Cost, AccPQ),
                            {NewDist1, NewPQ1}
                        else
                            {AccDist, AccPQ}
                        end
                    end,
                    {Dist, PQ2},
                    Neighbors
                ),
                dijkstra(Costs, NewDist, NewPQ, N)
            end
    end.

get_neighbors(V, N) ->
    case V of
        1 -> [2];
        N -> [N-1];
        _ -> [V-1, V+1]
    end.

infinity() -> 1000000000.