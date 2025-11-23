-module(solution).
-export([closest_node/3]).

closest_node(Nodes, u, v) ->
    Graph = lists:foldl(fun({X, Y}, Acc) -> lists:append(Acc, [{{X, Y}, []}]) end, [], Nodes),
    Map = lists:map(fun({X, Y}) -> {X, Y} end, Graph),
    DistsFromU = bfs(Map, u, []),
    DistsFromV = bfs(Map, v, []),
    find_closest(DistsFromU, DistsFromV).

bfs(Graph, Start, Visited) ->
    case lists:member(Start, Visited) of
        true -> Visited;
        false -> 
            Neighbors = lists:filter(fun({{X, _}, _}) -> X =:= Start end, Graph),
            NextVisited = [Start | Visited],
            lists:foldl(fun({{_, Y}, _}, Acc) -> bfs(Graph, Y, Acc) end, NextVisited, Neighbors)
    end.

find_closest(DistsFromU, DistsFromV) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, DistsFromV) of
            true -> if Acc == undefined -> X; true -> min(Acc, X) end;
            false -> Acc
        end
    end, undefined, DistsFromU).