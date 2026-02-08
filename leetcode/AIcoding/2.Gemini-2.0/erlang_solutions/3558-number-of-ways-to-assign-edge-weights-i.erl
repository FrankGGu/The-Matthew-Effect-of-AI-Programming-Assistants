-module(number_of_ways_to_assign_edge_weights_i).
-export([number_of_ways, solve/1]).

number_of_ways(N, Edges, Target) ->
    solve({N, Edges, Target}).

solve({N, Edges, Target}) ->
    graph_map(Edges, N, G),
    case solve_from_node(1, Target, G, N) of
        {ok, Ways} -> Ways;
        _ -> 0
    end.

graph_map(Edges, N, G) ->
    lists:foldl(fun({U, V}, Acc) ->
                        U_neighbors = maps:get(U, Acc, []),
                        V_neighbors = maps:get(V, Acc, []),
                        maps:put(U, [V | U_neighbors], maps:put(V, [U | V_neighbors], Acc))
                end, maps:new(), Edges).

solve_from_node(Start, Target, G, N) ->
    solve_helper(Start, Target, G, [Start], maps:new(), N).

solve_helper(Node, 0, _G, Path, Visited, N) when length(Path) == N ->
    {ok, 1};
solve_helper(_, Target, _G, Path, _Visited, _N) when Target < 0 ->
    {error, out_of_range};
solve_helper(Node, Target, G, Path, Visited, N) ->
    case maps:is_key(Node, Visited) of
        true ->
            {error, visited};
        false ->
            Neighbors = maps:get(Node, G, []),
            lists:foldl(fun(Neighbor, Acc) ->
                                case Acc of
                                    {ok, Count} ->
                                        case solve_helper(Neighbor, Target - 1, G, [Neighbor | Path], maps:put(Node, true, Visited), N) of
                                            {ok, NeighborCount} ->
                                                {ok, Count + NeighborCount};
                                            _ ->
                                                {ok, Count}
                                        end;
                                    _ ->
                                        Acc
                                end
                        end, {ok, 0}, Neighbors)
    end.