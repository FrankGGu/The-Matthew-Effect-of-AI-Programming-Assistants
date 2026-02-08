-module(maximum_k_divisible_components).
-export([solve/2]).

solve(N, K) ->
    solve(N, K, []).

solve(N, K, Edges) ->
    {AdjList, Values} = parse_input(N, Edges),
    solve_helper(AdjList, Values, K).

parse_input(N, Edges) ->
    AdjList = lists:foldl(fun({U, V}, Acc) ->
                                  Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                                        V => lists:append(maps:get(V, Acc, []), [U])}
                          end,
                          maps:new(), Edges),
    Values = lists:seq(1, N),
    {AdjList, lists:map(fun(_) -> 1 end, Values)}.

solve_helper(AdjList, Values, K) ->
    {Visited, Count} = dfs_all(AdjList, Values, K),
    Count.

dfs_all(AdjList, Values, K) ->
    N = length(Values),
    dfs_all(AdjList, Values, K, lists:seq(1, N), sets:new(), 0).

dfs_all(_AdjList, _Values, _K, [], Visited, Count) ->
    {Visited, Count};
dfs_all(AdjList, Values, K, [Node | Rest], Visited, Count) ->
    case sets:is_element(Node, Visited) of
        true ->
            dfs_all(AdjList, Values, K, Rest, Visited, Count);
        false ->
            {NewVisited, Sum, ComponentCount} = dfs(AdjList, Values, K, Node, Visited, 0, 0),
            NewCount = case Sum rem K == 0 of
                           true -> Count + ComponentCount;
                           false -> Count
                       end,
            dfs_all(AdjList, Values, K, Rest, NewVisited, NewCount)
    end.

dfs(AdjList, Values, K, Node, Visited, Sum, ComponentCount) ->
    case sets:is_element(Node, Visited) of
        true ->
            {Visited, Sum, ComponentCount};
        false ->
            NewVisited = sets:add_element(Node, Visited),
            NewSum = Sum + lists:nth(Node, Values),
            Neighbors = maps:get(Node, AdjList, []),
            {FinalVisited, FinalSum, FinalComponentCount} =
                lists:foldl(fun(Neighbor, {AccVisited, AccSum, AccCount}) ->
                                    dfs(AdjList, Values, K, Neighbor, AccVisited, AccSum, AccCount)
                            end, {NewVisited, NewSum, ComponentCount}, Neighbors),
            {FinalVisited, FinalSum, FinalComponentCount + 1}
    end.