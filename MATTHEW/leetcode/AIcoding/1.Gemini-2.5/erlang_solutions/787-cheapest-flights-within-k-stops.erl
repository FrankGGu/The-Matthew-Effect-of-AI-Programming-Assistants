-module(solution).
-export([findCheapestPrice/5]).

findCheapestPrice(_N, Flights, Src, Dst, K) ->
    Adj = lists:foldl(
        fun([From, To, Price], Acc) ->
            maps:update_with(From, fun(L) -> [{To, Price} | L] end, [{To, Price}], Acc)
        end,
        #{},
        Flights
    ),

    MinCosts = maps:put({Src, 0}, 0, #{}),

    PQ = gb_trees:insert({0, Src, 0}, {0, Src, 0}, gb_trees:empty()),

    MaxEdges = K + 1,
    ResultMinCosts = dijkstra(PQ, MinCosts, Adj, MaxEdges),

    MinPrice = find_min_price_to_dst(ResultMinCosts, Dst, MaxEdges),

    case MinPrice of
        infinity -> -1;
        _ -> MinPrice
    end.

dijkstra(PQ, MinCosts, Adj, MaxEdges) ->
    case gb_trees:is_empty(PQ) of
        true ->
            MinCosts;
        false ->
            {{Cost, City, EdgesUsed}, _, NewPQ} = gb_trees:take_min(PQ),

            case maps:get({City, EdgesUsed}, MinCosts, infinity) of
                ExistingCost when Cost > ExistingCost ->
                    dijkstra(NewPQ, MinCosts, Adj, MaxEdges);
                _ ->
                    Neighbors = maps:get(City, Adj, []),

                    {UpdatedPQ, UpdatedMinCosts} = lists:foldl(
                        fun({NextCity, FlightPrice}, {AccPQ, AccMinCosts}) ->
                            NewEdgesUsed = EdgesUsed + 1,
                            NewCost = Cost + FlightPrice,

                            if NewEdgesUsed =< MaxEdges and NewCost < maps:get({NextCity, NewEdgesUsed}, AccMinCosts, infinity) then
                                UpdatedAccMinCosts = maps:put({NextCity, NewEdgesUsed}, NewCost, AccMinCosts),
                                UpdatedAccPQ = gb_trees:insert({NewCost, NextCity, NewEdgesUsed}, {NewCost, NextCity, NewEdgesUsed}, AccPQ),
                                {UpdatedAccPQ, UpdatedAccMinCosts}
                            else
                                {AccPQ, AccMinCosts}
                            end
                        end,
                        {NewPQ, MinCosts},
                        Neighbors
                    ),
                    dijkstra(UpdatedPQ, UpdatedMinCosts, Adj, MaxEdges)
            end
    end.

find_min_price_to_dst(MinCosts, Dst, MaxEdges) ->
    lists:foldl(
        fun(EdgesUsed, AccMin) ->
            maps:get({Dst, EdgesUsed}, MinCosts, AccMin)
        end,
        infinity,
        lists:seq(0, MaxEdges)
    ).