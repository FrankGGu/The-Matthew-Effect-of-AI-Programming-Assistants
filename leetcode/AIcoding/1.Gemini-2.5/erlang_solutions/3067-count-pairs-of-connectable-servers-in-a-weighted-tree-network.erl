-module(solution).
-export([count_pairs_of_connectable_servers/2]).

count_pairs_of_connectable_servers(Edges, SignalSpeed) ->
    N = get_num_nodes(Edges),
    Adj = build_adj_list(N, Edges),
    lists:map(fun(I) -> calculate_pairs_for_node(I, N, Adj, SignalSpeed) end, lists:seq(0, N-1)).

get_num_nodes(Edges) ->
    lists:foldl(fun({U, V, _W}, Max) -> max(Max, max(U, V)) end, -1, Edges) + 1.

build_adj_list(N, Edges) ->
    array:foldl(
        fun({U, V, W}, Acc) ->
            Acc1 = array:set(U, [{V, W} | array:get(U, Acc)], Acc),
            array:set(V, [{U, W} | array:get(V, Acc1)], Acc1)
        end,
        array:new(N, {default, []}),
        Edges
    ).

calculate_pairs_for_node(Root, N, Adj, SignalSpeed) ->
    Neighbors = array:get(Root, Adj),
    calculate_pairs_for_node_recursive(Neighbors, Root, N, Adj, SignalSpeed, 0, 0).

calculate_pairs_for_node_recursive([], _Root, _N, _Adj, _SignalSpeed, _TotalMatchingSoFar, AccPairs) ->
    AccPairs;
calculate_pairs_for_node_recursive([{Neighbor, Weight} | Rest], Root, N, Adj, SignalSpeed, TotalMatchingSoFar, AccPairs) ->
    MatchingServersInSubtree = dfs_count(Neighbor, Root, Weight, SignalSpeed, Adj),
    NewAccPairs = AccPairs + (TotalMatchingSoFar * MatchingServersInSubtree),
    NewTotalMatchingSoFar = TotalMatchingSoFar + MatchingServersInSubtree,
    calculate_pairs_for_node_recursive(Rest, Root, N, Adj, SignalSpeed, NewTotalMatchingSoFar, NewAccPairs).

dfs_count(U, Parent, CurrentDist, SignalSpeed, Adj) ->
    IsMatching = if CurrentDist rem SignalSpeed == 0 -> 1; true -> 0 end,
    Neighbors = array:get(U, Adj),
    lists:foldl(
        fun({V, W}, Acc) ->
            if V == Parent ->
                Acc;
            true ->
                Acc + dfs_count(V, U, CurrentDist + W, SignalSpeed, Adj)
            end
        end,
        IsMatching,
        Neighbors
    ).