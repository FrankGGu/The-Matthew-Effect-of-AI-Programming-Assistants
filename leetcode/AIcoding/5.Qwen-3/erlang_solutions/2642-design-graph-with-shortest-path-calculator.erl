-module(solution).
-export([new/0, add_edge/3, shortest/2]).

new() ->
    {dict:new(), dict:new()}.

add_edge(From, To, Cost) ->
    Graph = get_graph(),
    EdgeCosts = get_edge_costs(),
    NewGraph = dict:update(From, fun(Edges) -> dict:store(To, Cost, Edges) end, dict:store(From, dict:new(), Graph)),
    NewEdgeCosts = dict:update({From, To}, fun(C) -> C + Cost end, dict:store({From, To}, Cost, EdgeCosts)),
    put_graph(NewGraph),
    put_edge_costs(NewEdgeCosts).

shortest(From, To) ->
    Graph = get_graph(),
    EdgeCosts = get_edge_costs(),
    case dict:is_key(From, Graph) of
        true ->
            Dijkstra:run(From, To, Graph, EdgeCosts);
        false ->
            -1
    end.

get_graph() ->
    erlang:get(graph).

put_graph(G) ->
    erlang:put(graph, G).

get_edge_costs() ->
    erlang:get(edge_costs).

put_edge_costs(EC) ->
    erlang:put(edge_costs, EC).

-module(dijkstra).
-export([run/4]).

run(Start, End, Graph, EdgeCosts) ->
    Nodes = dict:keys(Graph),
    Distances = dict:from_list([{N, infinity} || N <- Nodes]),
    UpdatedDistances = dict:store(Start, 0, Distances),
    Visited = dict:new(),
    dijkstra_loop(UpdatedDistances, Visited, Graph, EdgeCosts, End).

dijkstra_loop(Distances, Visited, Graph, EdgeCosts, End) ->
    {CurrentNode, CurrentDistance} = find_min_node(Distances, Visited),
    case CurrentNode of
        undefined ->
            case dict:is_key(End, Distances) of
                true -> dict:fetch(End, Distances);
                false -> -1
            end;
        _ ->
            NewVisited = dict:store(CurrentNode, true, Visited),
            Neighbors = dict:fetch(CurrentNode, Graph),
            UpdatedDistances = update_neighbors(Distances, Neighbors, CurrentNode, CurrentDistance, EdgeCosts),
            dijkstra_loop(UpdatedDistances, NewVisited, Graph, EdgeCosts, End)
    end.

find_min_node(Distances, Visited) ->
    find_min_node(Distances, Visited, undefined, infinity).

find_min_node(Dict, Visited, MinNode, MinDist) ->
    case dict:next(Dict) of
        {Key, Value, Rest} ->
            case dict:is_key(Key, Visited) of
                true -> find_min_node(Rest, Visited, MinNode, MinDist);
                false ->
                    if
                        Value < MinDist -> find_min_node(Rest, Visited, Key, Value);
                        true -> find_min_node(Rest, Visited, MinNode, MinDist)
                    end
            end;
        none ->
            {MinNode, MinDist}
    end.

update_neighbors(Distances, Neighbors, CurrentNode, CurrentDistance, EdgeCosts) ->
    update_neighbors(Neighbors, Distances, CurrentNode, CurrentDistance, EdgeCosts, dict:new()).

update_neighbors(Neighbors, Distances, CurrentNode, CurrentDistance, EdgeCosts, Acc) ->
    case dict:next(Neighbors) of
        {Neighbor, Cost, Rest} ->
            NewDistance = CurrentDistance + Cost,
            case dict:is_key(Neighbor, Distances) of
                true ->
                    ExistingDistance = dict:fetch(Neighbor, Distances),
                    if
                        NewDistance < ExistingDistance ->
                            UpdatedDistances = dict:store(Neighbor, NewDistance, Distances),
                            update_neighbors(Rest, UpdatedDistances, CurrentNode, CurrentDistance, EdgeCosts, Acc);
                        true ->
                            update_neighbors(Rest, Distances, CurrentNode, CurrentDistance, EdgeCosts, Acc)
                    end;
                false ->
                    UpdatedDistances = dict:store(Neighbor, NewDistance, Distances),
                    update_neighbors(Rest, UpdatedDistances, CurrentNode, CurrentDistance, EdgeCosts, Acc)
            end;
        none ->
            Acc
    end.