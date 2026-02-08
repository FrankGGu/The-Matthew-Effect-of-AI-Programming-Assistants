-module(solution).
-export([count_unreachable_pairs/2]).

count_unreachable_pairs(N, Edges) ->
    Graph = build_graph(N, Edges),
    Visited = sets:new(),
    Total = 0,
    Sccs = find_sccs(Graph, Visited),
    Count = lists:foldl(fun(Scc, Acc) -> Acc + length(Scc) end, 0, Sccs),
    lists:foldl(fun(Scc, Acc) ->
        Size = length(Scc),
        Acc + Size * (N - Size)
    end, 0, Sccs) div 2.

build_graph(N, Edges) ->
    lists:foldl(fun({U, V}, G) ->
        G1 = case maps:is_key(U, G) of
            true -> maps:update(U, [V | maps:get(U, G)], G);
            false -> maps:put(U, [V], G)
        end,
        G2 = case maps:is_key(V, G1) of
            true -> maps:update(V, [U | maps:get(V, G1)], G1);
            false -> maps:put(V, [U], G1)
        end,
        G2
    end, #{}, Edges).

find_sccs(Graph, Visited) ->
    find_sccs(Graph, Visited, []).

find_sccs(_, Visited, Sccs) when maps:size(Visited) == 0 ->
    Sccs;
find_sccs(Graph, Visited, Sccs) ->
    [Node | _] = maps:keys(Graph),
    {Scc, NewVisited} = dfs(Node, Graph, Visited, []),
    find_sccs(Graph, NewVisited, [Scc | Sccs]).

dfs(Node, Graph, Visited, Scc) ->
    case sets:is_element(Node, Visited) of
        true -> {Scc, Visited};
        false ->
            NewVisited = sets:add_element(Node, Visited),
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun(Neighbor, {SccAcc, VisitedAcc}) ->
                {NewScc, NewVisited} = dfs(Neighbor, Graph, VisitedAcc, SccAcc),
                {NewScc, NewVisited}
            end, {lists:reverse([Node | Scc]), NewVisited}, Neighbors)
    end.