-module(solution).
-export([count_complete_components/2]).

count_complete_components(N, Edges) ->
    Graph = build_graph(N, Edges),
    Visited = lists:duplicate(N, false),
    lists:foldl(fun(V, Acc) -> 
        if 
            not lists:nth(V + 1, Acc) -> 
                {Component, NewAcc} = dfs(V, Graph, Acc),
                case is_complete(Component, Graph) of
                    true -> 1 + NewAcc;
                    false -> NewAcc
                end
            ; 
                Acc 
        end
    end, 0, lists:seq(0, N - 1)).

build_graph(N, Edges) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({U, V}, Acc) -> 
        Acc1 = lists:update_element(U + 1, lists:nth(U + 1, Acc) ++ [V]), 
        lists:update_element(V + 1, lists:nth(V + 1, Acc1) ++ [U])
    end, Graph, Edges).

dfs(V, Graph, Visited) ->
    lists:foldl(fun(U, {Acc, Vis}) -> 
        if 
            not lists:nth(U + 1, Vis) -> 
                {Acc ++ [U], lists:update_element(U + 1, true, Vis)};
            true -> 
                {Acc, Vis}
        end
    end, {[V], lists:update_element(V + 1, true, Visited)}, Graph) 

is_complete(Component, Graph) ->
    Size = length(Component),
    lists:all(fun(V) -> length(Graph![V]) =:= Size - 1 end, Component).