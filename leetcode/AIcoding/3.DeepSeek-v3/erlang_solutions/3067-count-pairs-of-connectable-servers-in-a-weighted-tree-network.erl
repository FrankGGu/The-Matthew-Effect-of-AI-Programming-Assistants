-module(solution).
-export([count_pairs_of_connectable_servers/3]).

count_pairs_of_connectable_servers(Servers, Edges, SignalSpeed) ->
    N = length(Servers),
    Tree = build_tree(Edges, N),
    Result = lists:map(fun(I) -> count_connectable(Tree, Servers, SignalSpeed, I) end, lists:seq(0, N-1)),
    Result.

build_tree(Edges, N) ->
    Tree = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V, W], Acc) ->
                    U1 = U + 1,
                    V1 = V + 1,
                    Acc1 = array:set(U1, [{V1, W} | array:get(U1, Acc)], Acc),
                    array:set(V1, [{U1, W} | array:get(V1, Acc1)], Acc1)
                end, Tree, Edges).

count_connectable(Tree, Servers, SignalSpeed, I) ->
    I1 = I + 1,
    Children = array:get(I1, Tree),
    {Counts, _} = lists:mapfoldl(fun({Child, W}, Visited) ->
                                    {C, V} = dfs(Tree, Servers, SignalSpeed, Child, W, [I1 | Visited]),
                                    {C, V}
                                end, [I1], Children),
    Sum = lists:sum(Counts),
    lists:sum([C * (Sum - C) || C <- Counts]) div 2.

dfs(Tree, Servers, SignalSpeed, Node, Dist, Visited) ->
    case lists:member(Node, Visited) of
        true -> {0, Visited};
        false ->
            Children = array:get(Node, Tree),
            IsServer = lists:nth(Node - 1, Servers) rem SignalSpeed =:= 0,
            Count = if IsServer -> 1; true -> 0 end,
            {Counts, Visited1} = lists:mapfoldl(fun({Child, W}, V) ->
                                                    {C, V1} = dfs(Tree, Servers, SignalSpeed, Child, Dist + W, [Node | V]),
                                                    {C, V1}
                                                end, [Node | Visited], Children),
            {Count + lists:sum(Counts), Visited1}
    end.