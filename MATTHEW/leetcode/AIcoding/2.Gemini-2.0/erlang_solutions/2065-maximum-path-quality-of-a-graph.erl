-module(maximum_path_quality).
-export([maximum_path_quality/3]).

maximum_path_quality(Values, Edges, MaxTime) ->
    graph(Values, Edges, MaxTime).

graph(Values, Edges, MaxTime) ->
    Adj = build_adj(Edges),
    dfs(0, Values, Adj, MaxTime, [0], Values:nth(1), 0).

build_adj(Edges) ->
    lists:foldl(
        fun({U, V, Time}, Acc) ->
            Acc#{U => lists:append(maps:get(U, Acc, []), [{V, Time}]),
                  V => lists:append(maps:get(V, Acc, []), [{U, Time}])
                 }
        end,
        #{},
        Edges
    ).

dfs(Node, Values, Adj, Time, Path, Quality, MaxQuality) ->
    case Time < 0 of
        true ->
            MaxQuality;
        false ->
            Neighbors = maps:get(Node, Adj, []),
            case Neighbors of
                [] ->
                    max(MaxQuality, Quality);
                _ ->
                    lists:foldl(
                        fun({Neighbor, Cost}, AccMaxQuality) ->
                            NewTime = Time - Cost,
                            case NewTime < 0 of
                                true ->
                                    AccMaxQuality;
                                false ->
                                    case lists:member(Neighbor, Path) of
                                        true ->
                                            dfs(Neighbor, Values, Adj, NewTime, Path ++ [Neighbor], Quality, AccMaxQuality);
                                        false ->
                                            dfs(Neighbor, Values, Adj, NewTime, Path ++ [Neighbor], Quality + Values:nth(Neighbor + 1), AccMaxQuality)
                                    end
                            end
                        end,
                        MaxQuality,
                        Neighbors
                    )
            end
    end.