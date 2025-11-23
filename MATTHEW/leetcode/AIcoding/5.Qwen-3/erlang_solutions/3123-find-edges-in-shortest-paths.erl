-module(solution).
-export([find_edges/1]).

find_edges(Graph) ->
    Nodes = lists:usort(lists:flatten(Graph)),
    N = length(Nodes),
    Adj = build_adjacency(Graph, #{}),
    Dists = dijkstra(Adj, hd(Nodes)),
    Edges = find_shortest_edges(Adj, Dists),
    Edges.

build_adjacency([], Acc) -> Acc;
build_adjacency([[U,V,W]|Rest], Acc) ->
    NewAcc = add_edge(Acc, U, V, W),
    build_adjacency(Rest, NewAcc).

add_edge(Acc, U, V, W) ->
    UEdges = maps:get(U, Acc, []),
    VEdges = maps:get(V, Acc, []),
    maps:put(U, [{V, W} | UEdges], maps:put(V, [{U, W} | VEdges], Acc)).

dijkstra(Adj, Start) ->
    Dists = maps:from_list([{Node, infinity} || Node <- maps:keys(Adj)]),
    Dists1 = maps:put(Start, 0, Dists),
    dijkstra(Adj, Dists1, [Start]).

dijkstra(_, Dists, []) -> Dists;
dijkstra(Adj, Dists, [Node|Rest]) ->
    {NewDists, Queue} = process_node(Adj, Dists, Node, Rest),
    dijkstra(Adj, NewDists, Queue).

process_node(Adj, Dists, Node, Queue) ->
    Neighbors = maps:get(Node, Adj, []),
    lists:foldl(fun({Neighbor, Weight}, {CurrentDists, CurrentQueue}) ->
        CurrentDist = maps:get(Neighbor, CurrentDists),
        NewDist = maps:get(Node, CurrentDists) + Weight,
        if
            NewDist < CurrentDist ->
                {maps:put(Neighbor, NewDist, CurrentDists), [Neighbor | CurrentQueue]};
            true ->
                {CurrentDists, CurrentQueue}
        end
    end, {Dists, Queue}, Neighbors).

find_shortest_edges(Adj, Dists) ->
    Edges = lists:flatmap(fun({U, UEdges}) ->
        lists:map(fun({V, W}) ->
            case maps:get(U, Dists) + W == maps:get(V, Dists) of
                true -> {U, V};
                false -> []
            end
        end, UEdges)
    end, maps:to_list(Adj)),
    lists:usort(Edges).