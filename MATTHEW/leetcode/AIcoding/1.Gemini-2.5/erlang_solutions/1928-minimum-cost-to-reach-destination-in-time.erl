-module(solution).
-export([min_cost_to_reach_destination_in_time/3]).

-define(INF, 2_000_000_000).

min_cost_to_reach_destination_in_time(MaxTime, Edges, PassingFees) ->
    N = length(PassingFees),
    Adj = build_adj_list(N, Edges),

    PassingFeesArr = array:from_list(PassingFees),

    MinCostAtTime = init_min_cost_at_time_arrays(0, MaxTime, N, array:new(MaxTime + 1, {default, undefined})),

    InitialCost0 = array:get(0, PassingFeesArr),

    MinCostAtTime0 = array:set(0, array:set(0, InitialCost0, array:get(0, MinCostAtTime)), MinCostAtTime),

    PQ = gb_trees:insert({InitialCost0, 0}, 0, gb_trees:empty()),

    FinalMinCostAtTime = dijkstra(PQ, MaxTime, N, Adj, PassingFeesArr, MinCostAtTime0),

    MinResult = find_min_cost_to_destination(0, MaxTime, N - 1, FinalMinCostAtTime, ?INF),

    case MinResult of
        ?INF -> -1;
        _ -> MinResult
    end.

build_adj_list(N, Edges) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(fun([U, V, TravelTime, Cost], AccAdj) ->
        AdjU = array:get(U, AccAdj),
        array:set(U, [{V, TravelTime, Cost} | AdjU], AccAdj)
    end, Adj, Edges).

init_min_cost_at_time_arrays(Time, MaxTime, N, Acc) when Time =< MaxTime ->
    Acc1 = array:set(Time, array:new(N, {default, ?INF}), Acc),
    init_min_cost_at_time_arrays(Time + 1, MaxTime, N, Acc1);
init_min_cost_at_time_arrays(_Time, _MaxTime, _N, Acc) ->
    Acc.

dijkstra(PQ, MaxTime, N, Adj, PassingFeesArr, MinCostAtTime) ->
    case gb_trees:is_empty(PQ) of
        true ->
            MinCostAtTime;
        false ->
            {{Cost, Time}, City, RestPQ} = gb_trees:take_smallest(PQ),

            CurrentMinCost = array:get(City, array:get(Time, MinCostAtTime)),

            if Cost > CurrentMinCost ->
                dijkstra(RestPQ, MaxTime, N, Adj, PassingFeesArr, MinCostAtTime);
            true ->
                Neighbors = array:get(City, Adj),
                {NewPQ, NewMinCostAtTime} = lists:foldl(fun({Neighbor, TravelTime, EdgeCost}, {AccPQ, AccMinCostAtTime}) ->
                    NewTime = Time + TravelTime,
                    if NewTime =< MaxTime ->
                        NewCost = Cost + EdgeCost + array:get(Neighbor, PassingFeesArr),
                        NeighborMinCostAtTime = array:get(Neighbor, array:get(NewTime, AccMinCostAtTime)),
                        if NewCost < NeighborMinCostAtTime ->
                            AccMinCostAtTime1 = array:set(NewTime, array:set(Neighbor, NewCost, array:get(NewTime, AccMinCostAtTime)), AccMinCostAtTime),
                            AccPQ1 = gb_trees:insert({NewCost, NewTime}, Neighbor, AccPQ),
                            {AccPQ1, AccMinCostAtTime1};
                        true ->
                            {AccPQ, AccMinCostAtTime}
                        end;
                    true ->
                        {AccPQ, AccMinCostAtTime}
                    end
                end, {RestPQ, MinCostAtTime}, Neighbors),
                dijkstra(NewPQ, MaxTime, N, Adj, PassingFeesArr, NewMinCostAtTime)
            end
    end.

find_min_cost_to_destination(Time, MaxTime, DestinationCity, FinalMinCostAtTime, MinResult) when Time =< MaxTime ->
    CostAtTime = array:get(DestinationCity, array:get(Time, FinalMinCostAtTime)),
    NewMinResult = min(MinResult, CostAtTime),
    find_min_cost_to_destination(Time + 1, MaxTime, DestinationCity, FinalMinCostAtTime, NewMinResult);
find_min_cost_to_destination(_Time, _MaxTime, _DestinationCity, _FinalMinCostAtTime, MinResult) ->
    MinResult.