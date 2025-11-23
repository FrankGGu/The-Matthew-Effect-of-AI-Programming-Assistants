-module(solution).
-export([getAncestors/3]).

getAncestors(Node, Edges, N) ->
    Graph = build_graph(Edges),
    Ancestors = find_ancestors(Node, Graph, []),
    lists:sort(Ancestors).

build_graph(Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        maps:update_with(B, fun(X) -> [A | X] end, [A], Acc)
    end, #{}, Edges).

find_ancestors(Node, Graph, Visited) ->
    case maps:get(Node, Graph, []) of
        [] -> Visited;
        Parents ->
            lists:foldl(fun(Parent, Acc) ->
                if
                    lists:member(Parent, Acc) -> Acc;
                    true -> find_ancestors(Parent, Graph, [Parent | Acc])
                end
            end, Visited, Parents)
    end.