-module(frog_position).
-export([frog_position/3]).

frog_position(N, Edges, T, Target) ->
    graph_map(Edges, N, Graph),
    bfs(1, Target, T, Graph, [false|_], 1.0).

graph_map(Edges, N, Graph) ->
    lists:foldl(
        fun([A, B], Acc) ->
            Acc#{A => lists:sort(Acc[A] ++ [B]), B => lists:sort(Acc[B] ++ [A])}
        end,
        maps:from_list([{I, []} || I <- lists:seq(1, N)]),
        Edges
    ).

bfs(Node, Target, Time, Graph, Visited, Prob) ->
    case Time of
        0 ->
            case Node == Target of
                true ->
                    case maps:get(Node, Graph, []) of
                        [] -> Prob;
                        Neighbors ->
                            lists:all(fun(Neighbor) -> lists:nth(Neighbor, Visited) end, Neighbors) -> Prob;
                        _ -> 0.0
                    end;
                false -> 0.0
            end;
        _ ->
            Neighbors = lists:filter(fun(Neighbor) -> not lists:nth(Neighbor, Visited) end, maps:get(Node, Graph, [])),
            case Neighbors of
                [] ->
                    case Node == Target of
                        true -> Prob;
                        false -> 0.0
                    end;
                _ ->
                    NewProb = Prob / length(Neighbors),
                    lists:sum([bfs(Neighbor, Target, Time - 1, Graph, lists:replace_nth(Node, true, Visited), NewProb) || Neighbor <- Neighbors])
            end
    end.