-module(min_degree_of_connected_trio_in_a_graph).
-export([minTrio/1]).

minTrio(Edges) ->
    Graph = build_graph(Edges),
    Nodes = maps:keys(Graph),
    min_degree(Nodes, Graph, infinity).

build_graph(Edges) ->
    build_graph(Edges, #{}).

build_graph([], Graph) ->
    Graph;
build_graph([[U, V] | Rest], Graph) ->
    Graph1 = add_edge(U, V, Graph),
    Graph2 = add_edge(V, U, Graph1),
    build_graph(Rest, Graph2).

add_edge(Node, Neighbor, Graph) ->
    case maps:find(Node, Graph) of
        {ok, Neighbors} ->
            maps:update(Node, [Neighbor | Neighbors], Graph);
        error ->
            maps:put(Node, [Neighbor], Graph)
    end.

min_degree([], _Graph, Min) ->
    Min;
min_degree([A | Rest], Graph, Min) ->
    NeighborsA = maps:get(A, Graph, []),
    lists:foreach(fun(B) ->
        case lists:member(B, NeighborsA) of
            true ->
                NeighborsB = maps:get(B, Graph, []),
                lists:foreach(fun(C) ->
                    case lists:member(C, NeighborsB) andalso C > B andalso lists:member(C, NeighborsA) of
                        true ->
                            DegreeA = length(maps:get(A, Graph)),
                            DegreeB = length(maps:get(B, Graph)),
                            DegreeC = length(maps:get(C, Graph)),
                            CurrentMin = min(DegreeA + DegreeB + DegreeC, Min),
                            erlang:put(current_min, CurrentMin);
                        false ->
                            ok
                    end
                end, NeighborsA);
            false ->
                ok
        end
    end, NeighborsA),
    min_degree(Rest, Graph, Min).

min_degree([], _Graph, Min) ->
    Min;
min_degree([A | Rest], Graph, Min) ->
    NeighborsA = maps:get(A, Graph, []),
    lists:foreach(fun(B) ->
        case lists:member(B, NeighborsA) of
            true ->
                NeighborsB = maps:get(B, Graph, []),
                lists:foreach(fun(C) ->
                    case lists:member(C, NeighborsB) andalso C > B andalso lists:member(C, NeighborsA) of
                        true ->
                            DegreeA = length(maps:get(A, Graph)),
                            DegreeB = length(maps:get(B, Graph)),
                            DegreeC = length(maps:get(C, Graph)),
                            CurrentMin = min(DegreeA + DegreeB + DegreeC, Min),
                            erlang:put(current_min, CurrentMin);
                        false ->
                            ok
                    end
                end, NeighborsA);
            false ->
                ok
        end
    end, NeighborsA),
    min_degree(Rest, Graph, Min).