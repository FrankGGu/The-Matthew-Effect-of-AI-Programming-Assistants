-module(valid_arrangement).
-export([find_itinerary/1]).

find_itinerary(pairs) ->
    graph(pairs, Graph),
    start_node(Graph, Start),
    eulerian_path(Graph, Start, []).

graph(Pairs, Graph) ->
    lists:foldl(
        fun({U, V}, Acc) ->
            Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                  V => maps:get(V, Acc, [])}
        end,
        #{},
        Pairs
    ).

start_node(Graph, Start) ->
    Degrees = maps:fold(
        fun(Node, Neighbors, Acc) ->
            OutDegree = length(Neighbors),
            InDegree = count_in_degree(Node, Graph),
            Acc#{Node => OutDegree - InDegree}
        end,
        #{},
        Graph
    ),
    case lists:keyfind(1, 2, maps:to_list(Degrees)) of
        {Node, _} ->
            Node;
        false ->
            maps:keys(Graph) hd
    end.

count_in_degree(Node, Graph) ->
    maps:fold(
        fun(U, Neighbors, Acc) ->
            case lists:member(Node, Neighbors) of
                true ->
                    Acc + lists:filter(fun(X) -> X == Node end, Neighbors) length;
                false ->
                    Acc
            end
        end,
        0,
        Graph
    ).

eulerian_path(Graph, Start, Acc) ->
    case maps:get(Start, Graph, []) of
        [] ->
            lists:reverse([Start | Acc]);
        Neighbors ->
            V = hd(Neighbors),
            NewGraph = remove_edge(Graph, Start, V),
            eulerian_path(NewGraph, V, [Start | Acc])
    end.

remove_edge(Graph, U, V) ->
    NewNeighborsU = lists:delete(V, maps:get(U, Graph)),
    case NewNeighborsU of
        [] ->
            maps:remove(U, Graph);
        _ ->
            Graph#{U => NewNeighborsU}
    end.