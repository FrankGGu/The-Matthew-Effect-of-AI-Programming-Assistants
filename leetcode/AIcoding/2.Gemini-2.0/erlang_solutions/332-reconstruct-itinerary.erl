-module(reconstruct_itinerary).
-export([find_itinerary/1]).

find_itinerary(tickets) ->
    graph_to_itinerary(build_graph(tickets), "JFK", []).

build_graph(Tickets) ->
    build_graph(Tickets, #{}, []).

build_graph([], Graph, Acc) ->
    lists:foldl(fun(Key, Acc2) ->
                        Sorted = lists:sort(fun(A, B) -> A < B end, maps:get(Key, Graph, [])),
                        maps:put(Key, Sorted, Acc2)
                end, #{}, maps:keys(Graph));
build_graph([[From, To] | Rest], Graph, Acc) ->
    NewGraph = maps:update_with(From, fun(V) -> [To | V] end, [To], Graph),
    build_graph(Rest, NewGraph, Acc).

graph_to_itinerary(Graph, Airport, Itinerary) ->
    case maps:get(Airport, Graph, []) of
        [] ->
            lists:reverse([Airport | Itinerary]);
        Destinations ->
            To = hd(Destinations),
            NewGraph = maps:update(Airport, fun(_) -> tl(Destinations) end, Graph),
            graph_to_itinerary(NewGraph, To, [Airport | Itinerary])
    end.