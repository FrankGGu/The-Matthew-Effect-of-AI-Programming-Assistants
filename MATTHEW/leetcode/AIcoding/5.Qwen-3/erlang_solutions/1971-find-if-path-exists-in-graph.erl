-module(solution).
-export([valid_path/2]).

valid_path(Edges, Node1) ->
    Graph = build_graph(Edges),
    visited = sets:new(),
    dfs(Node1, Graph, visited).

build_graph(Edges) ->
    lists:foldl(fun({A,B}, Acc) ->
        Acc#{A => sets:add_element(B, maps:get(A, Acc, sets:new())),
             B => sets:add_element(A, maps:get(B, Acc, sets:new()))}
    end, #{}, Edges).

dfs(Node, Graph, Visited) ->
    case sets:is_element(Node, Visited) of
        true -> false;
        false ->
            Visited1 = sets:add_element(Node, Visited),
            case maps:get(Node, Graph, []) of
                [] -> true;
                Neighbors ->
                    lists:any(fun(Neighbor) -> dfs(Neighbor, Graph, Visited1) end, sets:to_list(Neighbors))
            end
    end.