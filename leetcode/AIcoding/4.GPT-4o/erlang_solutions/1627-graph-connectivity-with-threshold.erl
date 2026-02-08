-module(solution).
-export([are_connected/3]).

are_connected(N, E, T) ->
    Graph = lists:foldl(fun({A, B}, Acc) -> add_edge(A, B, Acc) end, lists:duplicate(N + 1, []), E),
    Visited = lists:duplicate(N + 1, false),
    ConnectedComponents = find_components(Graph, T, Visited, 1, []),
    lists:member(1, ConnectedComponents).

add_edge(A, B, Acc) ->
    lists:update_element(A, lists:append(lists:nth(A, Acc), [B]), Acc).

find_components(Graph, T, Visited, Node, Acc) ->
    case lists:nth(Node, Visited) of
        true -> Acc;
        false ->
            NewVisited = lists:update_element(Node, true, Visited),
            Neighbours = lists:nth(Node, Graph),
            NewAcc = [Node | Acc],
            lists:foldl(fun(N, Acc1) -> find_components(Graph, T, NewVisited, N, Acc1) end, NewAcc, lists:filter(fun(N) -> N > T end, Neighbours))
    end.