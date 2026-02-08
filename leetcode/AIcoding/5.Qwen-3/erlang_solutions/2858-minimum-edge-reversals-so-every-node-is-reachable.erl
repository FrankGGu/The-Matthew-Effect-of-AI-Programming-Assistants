-module(min_edge_reversals).
-export([minEdgeReversals/1]).

minEdgeReversals(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    Graph = build_graph(Nodes, Edges),
    {InDegree, OutDegree} = count_degrees(Graph),
    {_, Result} = dfs(0, -1, Graph, InDegree, OutDegree, 0),
    Result.

build_graph(Nodes, Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => maps:get(A, Acc, []), B => maps:get(B, Acc, []) ++ [A]}
    end, #{}, Edges).

count_degrees(Graph) ->
    lists:foldl(fun(Node, {In, Out}) ->
        Neighbors = maps:get(Node, Graph, []),
        InCount = length([N || N <- Neighbors, lists:member(N, maps:keys(Graph))]),
        OutCount = length(Neighbors) - InCount,
        {maps:put(Node, InCount, In), maps:put(Node, OutCount, Out)}
    end, #{}, maps:keys(Graph)).

dfs(Node, Parent, Graph, InDegree, OutDegree, Count) ->
    lists:foldl(fun(Child, {In, Out, Cnt}) ->
        if Child /= Parent ->
            NewIn = maps:get(Child, In),
            NewOut = maps:get(Child, Out),
            if NewIn > 0 ->
                {maps:put(Child, NewIn - 1, In), maps:put(Child, NewOut + 1, Out), Cnt + 1};
            true ->
                {maps:put(Child, NewIn + 1, In), maps:put(Child, NewOut - 1, Out), Cnt}
            end;
        true ->
            {In, Out, Cnt}
        end
    end, {InDegree, OutDegree, Count}, maps:get(Node, Graph, [])).