-module(mht).
-export([find_min_height_trees/1]).

find_min_height_trees(N) ->
    find_min_height_trees(N, []).

find_min_height_trees(N, Edges) ->
    Graph = build_graph(N, Edges),
    Leaves = [I || I <- lists:seq(0, N-1), length(graph_get(Graph, I)) == 1],
    case Leaves of
        [] when N == 1 -> [0];
        _ -> process_leaves(Graph, Leaves, N)
    end.

build_graph(N, Edges) ->
    Graph = lists:foldl(fun(I, Acc) -> dict:store(I, [], Acc) end, dict:new(), lists:seq(0, N-1)),
    lists:foldl(fun({U, V}, Acc) ->
        Acc1 = dict:update_with(U, fun(L) -> [V | L] end, Acc),
        dict:update_with(V, fun(L) -> [U | L] end, Acc1)
    end, Graph, Edges).

graph_get(Graph, Key) ->
    dict:fetch(Key, Graph).

process_leaves(Graph, Leaves, N) ->
    case N of
        1 -> Leaves;
        _ ->
            NewN = N - length(Leaves),
            NewGraph = remove_leaves(Graph, Leaves),
            NewLeaves = [I || I <- lists:seq(0, NewN-1), length(graph_get(NewGraph, I)) == 1],
            process_leaves(NewGraph, NewLeaves, NewN)
    end.

remove_leaves(Graph, Leaves) ->
    lists:foldl(fun(Leaf, Acc) ->
        lists:foldl(fun(Node, Acc2) ->
            dict:update_with(Node, fun(L) -> lists:delete(Leaf, L) end, Acc2)
        end, Acc, graph_get(Graph, Leaf))
    end, Graph, Leaves).