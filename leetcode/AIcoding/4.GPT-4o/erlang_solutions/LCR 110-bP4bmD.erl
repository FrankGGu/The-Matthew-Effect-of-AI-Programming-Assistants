-module(solution).
-export([all_paths/2]).

all_paths(Graph, Start) ->
    all_paths_helper(Graph, Start, []).

all_paths_helper(_, Node, Visited) when lists:member(Node, Visited) ->
    [];
all_paths_helper(Graph, Node, Visited) ->
    NewVisited = [Node | Visited],
    case maps:get(Node, Graph, []) of
        [] -> [lists:reverse(NewVisited)];
        Neighbors -> 
            lists:flatmap(fun(Neighbor) -> all_paths_helper(Graph, Neighbor, NewVisited) end, Neighbors)
    end.