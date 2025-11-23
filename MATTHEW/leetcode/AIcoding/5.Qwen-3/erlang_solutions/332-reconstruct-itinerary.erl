-module(reconstruct_itinerary).
-export([findItinerary/1]).

findItinerary(Tickets) ->
    Graph = build_graph(Tickets),
    [Start | _] = lists:usort([Src || {Src, _} <- Tickets]),
    Itinerary = [],
    dfs(Start, Graph, Itinerary).

build_graph(Tickets) ->
    maps:fold(
        fun({Src, Dest}, _, Acc) ->
            case maps:is_key(Src, Acc) of
                true -> maps:update(Src, [Dest | maps:get(Src, Acc)], Acc);
                false -> maps:put(Src, [Dest], Acc)
            end
        end,
        #{},
        Tickets
    ).

dfs(Node, Graph, Itinerary) ->
    case maps:is_key(Node, Graph) of
        true ->
            Neighbors = lists:sort(maps:get(Node, Graph)),
            lists:foldl(
                fun(Neighbor, Acc) ->
                    NewGraph = maps:update(Node, lists:delete(Neighbor, maps:get(Node, Graph)), Graph),
                    dfs(Neighbor, NewGraph, [Node | Acc])
                end,
                Itinerary,
                Neighbors
            );
        false ->
            [Node | Itinerary]
    end.