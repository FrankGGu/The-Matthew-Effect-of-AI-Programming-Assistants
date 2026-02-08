-module(solution).
-export([makeConnected/2]).

makeConnected(N, Connections) ->
    case length(Connections) >= N - 1 of
        false -> -1;
        true -> 
            Graph = lists:foldl(fun({a, b}, Acc) -> connect(a, b, Acc) end, lists:duplicate(N, []), Connections),
            Components = count_components(Graph, N),
            Components - 1
    end.

connect(A, B, Graph) ->
    lists:map(fun({Index, Neighbors}) ->
        case Index of
            A -> {Index, lists:usort([B | Neighbors])};
            B -> {Index, lists:usort([A | Neighbors])};
            _ -> {Index, Neighbors}
        end
    end, lists:zip(lists:seq(0, length(Graph) - 1), Graph)).

count_components(Graph, N) ->
    Visited = lists:duplicate(N, false),
    count_components_helper(Graph, Visited, 0, N).

count_components_helper(_, Visited, Count, N) when Count >= N -> Count;
count_components_helper(Graph, Visited, Count, N) ->
    case lists:find(fun(X) -> not X end, Visited) of
        false -> Count;
        {ok, Index} ->
            Visited1 = visit(Graph, Index, Visited),
            count_components_helper(Graph, Visited1, Count + 1, N)
    end.

visit(Graph, Index, Visited) ->
    case lists:nth(Index + 1, Graph) of
        [] -> Visited;
        Neighbors -> 
            Visited1 = lists:replace(Index + 1, true, Visited),
            lists:foldl(fun(N, Acc) -> visit(Graph, N, Acc) end, Visited1, Neighbors)
    end.