-module(solution).
-export([min_score/2]).

min_score(N, Roads) ->
    Adj = build_adj(N, Roads),
    {Min, _} = dfs(1, Adj, maps:new(), infinity),
    Min.

build_adj(N, Roads) ->
    Adj = lists:foldl(fun(_, Acc) -> Acc ++ [#{}] end, [], lists:seq(1, N)),
    lists:foldl(fun([U, V, D], Acc) ->
                    UMap = maps:get(U, Acc, #{}),
                    VMap = maps:get(V, Acc, #{}),
                    Acc1 = Acc#{U => UMap#{V => D}},
                    Acc1#{V => VMap#{U => D}}
                end, Adj, Roads).

dfs(Node, Adj, Visited, Min) ->
    case maps:is_key(Node, Visited) of
        true -> {Min, Visited};
        false ->
            Visited1 = Visited#{Node => true},
            Neighbors = maps:get(Node, Adj, #{}),
            {NewMin, Visited2} = maps:fold(fun(Neighbor, Dist, {CurrentMin, CurrentVisited}) ->
                                               {TempMin, TempVisited} = dfs(Neighbor, Adj, CurrentVisited, min(CurrentMin, Dist)),
                                               {min(TempMin, CurrentMin), TempVisited}
                                           end, {Min, Visited1}, Neighbors),
            {NewMin, Visited2}
    end.