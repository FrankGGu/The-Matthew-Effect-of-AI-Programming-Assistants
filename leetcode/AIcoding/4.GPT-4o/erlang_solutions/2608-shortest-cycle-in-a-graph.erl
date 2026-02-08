-module(solution).
-export([find_shortest_cycle/1]).

find_shortest_cycle(Graph) ->
    Vertices = lists:seq(1, length(Graph)),
    lists:min(lists:map(fun(Vertex) -> bfs(Vertex, Graph, Vertices, [], 0) end, Vertices)).

bfs(Start, Graph, Vertices, Visited, Depth) ->
    case lists:keyfind(Start, 1, Visited) of
        false ->
            NewVisited = [{Start, Depth} | Visited],
            Adj = lists:nth(Start, Graph),
            lists:min(lists:map(fun(Neighbor) -> 
                if 
                    Neighbor =:= Start -> Depth + 1; 
                    true -> bfs(Neighbor, Graph, Vertices, NewVisited, Depth + 1) 
                end 
            end, Adj));
        {Start, D} -> 
            Depth + D + 1 
    end.