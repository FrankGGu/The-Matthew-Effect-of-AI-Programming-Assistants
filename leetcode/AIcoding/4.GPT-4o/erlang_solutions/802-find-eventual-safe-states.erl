-module(solution).
-export([eventual_safe_nodes/1]).

eventual_safe_nodes(Graph) ->
    N = length(Graph),
    AdjList = lists:map(fun(L) -> lists:map(fun(X) -> X - 1 end, L) end, Graph),
    Safe = lists:map(fun(X) -> is_safe(X, AdjList, []) end, lists:seq(0, N - 1)),
    lists:filter(fun({Index, Safe}) -> Safe end, lists:zip(lists:seq(0, N - 1), Safe)).

is_safe(Node, Graph, Visited) ->
    if
        lists:member(Node, Visited) -> false;
        Graph(Node) == [] -> true;
        true -> 
            is_safe_nodes(Node, Graph, [Node | Visited])
    end.

is_safe_nodes(Node, Graph, Visited) ->
    case lists:nth(Node + 1, Graph) of
        [] -> true;
        Neighbors -> 
            lists:all(fun(Neighbor) -> is_safe(Neighbor, Graph, Visited) end, Neighbors)
    end.