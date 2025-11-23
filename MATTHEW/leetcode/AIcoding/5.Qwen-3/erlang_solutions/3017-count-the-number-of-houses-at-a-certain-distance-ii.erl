-module(solution).
-export([distance_k/2]).

distance_k(Edges, K) ->
    Graph = build_graph(Edges),
    N = length(Graph),
    Visited = array:new(N, {default, false}),
    Result = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> dfs(I, 0, K, Graph, Visited, Result) end, lists:seq(0, N-1)),
    array:to_list(Result).

build_graph(Edges) ->
    F = fun({A, B}, Acc) ->
            Acc#{A => [B | maps:get(A, Acc, [])], B => [A | maps:get(B, Acc, [])]}
        end,
    lists:foldl(F, #{}, Edges).

dfs(Node, Dist, K, Graph, Visited, Result) ->
    case array:get(Node, Visited) of
        true -> ok;
        _ ->
            array:set(Node, true, Visited),
            if Dist == K ->
                array:set(Node, array:get(Node, Result) + 1, Result);
            true ->
                ok
            end,
            lists:foreach(fun(Child) ->
                                dfs(Child, Dist + 1, K, Graph, Visited, Result)
                          end, maps:get(Node, Graph, []))
    end.