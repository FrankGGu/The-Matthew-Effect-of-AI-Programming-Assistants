-module(path_with_maximum_probability).
-export([maxProbability/5]).

maxProbability(NumNodes, Edges, Start, End, SuccessProb) ->
    Graph = build_graph(Edges, SuccessProb),
    {_, MaxProb} = dijkstra(NumNodes, Graph, Start, End),
    MaxProb.

build_graph([], _) -> [];
build_graph([[A,B|_]=Edge | Rest], Prob) ->
    [{{A,B}, Prob} | build_graph(Rest, Prob)].

dijkstra(NumNodes, Graph, Start, End) ->
    Dist = maps:from_list([{N, 0.0} || N <- lists:seq(1, NumNodes)]),
    Dist1 = maps:update(Start, 1.0, Dist),
    Visited = sets:new(),
    Queue = [{1.0, Start}],
    dijkstra_loop(Queue, Dist1, Visited, Graph, End).

dijkstra_loop([], _, _, _, _) -> {error, 0.0};
dijkstra_loop([{Prob, Node} | Rest], Dist, Visited, Graph, End) ->
    case Node of
        End -> {ok, Prob};
        _ ->
            case sets:is_element(Node, Visited) of
                true -> dijkstra_loop(Rest, Dist, Visited, Graph, End);
                false ->
                    NewVisited = sets:add_element(Node, Visited),
                    Neighbors = get_neighbors(Graph, Node),
                    Dist1 = update_distances(Neighbors, Prob, Dist),
                    NewQueue = lists:foldl(fun({Neighbor, P}, Acc) ->
                        {NewProb, _} = maps:get(Neighbor, Dist1),
                        [{NewProb, Neighbor} | Acc]
                    end, Rest, Neighbors),
                    dijkstra_loop(lists:sort(NewQueue), Dist1, NewVisited, Graph, End)
            end
    end.

get_neighbors(Graph, Node) ->
    lists:filter(fun({{A, B}, _}) -> A == Node orelse B == Node end, Graph).

update_distances([], _, Dist) -> Dist;
update_distances([{Node, P} | Rest], CurrentProb, Dist) ->
    NewProb = CurrentProb * P,
    case maps:get(Node, Dist) of
        OldProb when OldProb >= NewProb -> update_distances(Rest, CurrentProb, Dist);
        _ -> update_distances(Rest, CurrentProb, maps:update(Node, NewProb, Dist))
    end.