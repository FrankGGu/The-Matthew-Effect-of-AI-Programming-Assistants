-module(solution).
-export([maximum_points/2]).

maximum_points(Edges, Coins) ->
    N = length(Coins),
    G = build_graph(Edges, N),
    DP = maps:new(),
    {Ans, _} = dfs(0, -1, 0, G, Coins, DP),
    Ans.

build_graph(Edges, N) ->
    G = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = setelement(U + 1, Acc, [V | element(U + 1, Acc)]),
                    setelement(V + 1, Acc1, [U | element(V + 1, Acc1)])
                end, G, Edges).

dfs(Node, Parent, K, G, Coins, DP) ->
    Key = {Node, K},
    case maps:get(Key, DP, undefined) of
        undefined ->
            Total1 = 0,
            Total2 = 0,
            Children = lists:filter(fun(Child) -> Child =/= Parent end, element(Node + 1, G)),
            lists:foreach(fun(Child) ->
                {T1, DP1} = dfs(Child, Node, K, G, Coins, DP),
                {T2, DP2} = dfs(Child, Node, K + 1, G, Coins, DP1),
                Total1 = Total1 + T1,
                Total2 = Total2 + T2,
                DP = DP2
            end, Children),
            Coin = lists:nth(Node + 1, Coins),
            Val1 = (Coin bsr K) - 0,
            Val2 = (Coin bsr (K + 1)) - 2,
            MaxVal = max(Total1 + Val1, Total2 + Val2),
            DPNew = maps:put(Key, {MaxVal, DP}, DP),
            {MaxVal, DPNew};
        {Val, DP} ->
            {Val, DP}
    end.