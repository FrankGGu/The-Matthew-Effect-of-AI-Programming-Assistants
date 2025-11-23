-module(cheapest_flights_within_k_stops).
-export([find_cheapest_flights/3]).

find_cheapest_flights(NumFlights, Flights, Src) ->
    {ok, Graph} = build_graph(Flights),
    {ok, Distances} = dijkstra(Graph, Src, NumFlights),
    case maps:get(Src, Distances, infinity) of
        infinity -> -1;
        D -> D
    end.

build_graph([]) ->
    {ok, #{}};
build_graph([{From, To, Price} | Rest]) ->
    {ok, Graph} = build_graph(Rest),
    FromMap = maps:get(From, Graph, #{}),
    UpdatedFromMap = maps:put(To, Price, FromMap),
    {ok, maps:put(From, UpdatedFromMap, Graph)}.

dijkstra(Graph, Start, MaxStops) ->
    Distances = maps:from_list([{N, infinity} || N <- maps:keys(Graph)]),
    DistancesWithStart = maps:put(Start, 0, Distances),
    Queue = queue:from_list([{0, Start, 0}]),
    dijkstra_loop(Queue, Graph, DistancesWithStart, MaxStops).

dijkstra_loop(Queue, _Graph, Distances, _MaxStops) when queue:is_empty(Queue) ->
    {ok, Distances};
dijkstra_loop(Queue, Graph, Distances, MaxStops) ->
    {_, {Cost, Node, Stops}, NewQueue} = queue:out(Queue),
    case maps:get(Node, Distances, infinity) of
        Cost ->
            lists:foreach(fun({To, Price}) ->
                NewCost = Cost + Price,
                NewStops = Stops + 1,
                case NewStops =< MaxStops of
                    true ->
                        case maps:get(To, Distances, infinity) of
                            NewCost -> ok;
                            _ ->
                                NewDistances = maps:put(To, NewCost, Distances),
                                NewQueue2 = queue:in({NewCost, To, NewStops}, NewQueue),
                                dijkstra_loop(NewQueue2, Graph, NewDistances, MaxStops)
                        end;
                    false -> ok
                end
            end, maps:get(Node, Graph, [])),
            dijkstra_loop(NewQueue, Graph, Distances, MaxStops);
        _ ->
            dijkstra_loop(NewQueue, Graph, Distances, MaxStops)
    end.