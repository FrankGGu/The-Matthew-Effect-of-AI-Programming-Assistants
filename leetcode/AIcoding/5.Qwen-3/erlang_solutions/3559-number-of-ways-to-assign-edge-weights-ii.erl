-module(number_of_ways_to_assign_edge_weights_ii).
-export([numWays/1]).

numWays(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    N = length(Nodes),
    Graph = build_graph(Edges),
    {Min, Max} = find_min_max_edges(Graph, 0, 0),
    case Min of
        0 -> 0;
        _ -> pow(2, N - 1)
    end.

build_graph([]) -> [];
build_graph([[U, V] | T]) ->
    [{U, V} | build_graph(T)].

find_min_max_edges([], Min, Max) -> {Min, Max};
find_min_max_edges([{U, V} | T], Min, Max) ->
    NewMin = min(Min, U),
    NewMax = max(Max, V),
    find_min_max_edges(T, NewMin, NewMax).

pow(_, 0) -> 1;
pow(X, Y) -> X * pow(X, Y - 1).