-module(solution).
-export([max_k_divisible_components/3]).

dfs(U, P, Adj, ValuesArr, K) ->
    NodeValue = array:get(U, ValuesArr),
    Children = maps:get(U, Adj, []),

    {SubtreeSumFromChildren, ComponentsFromChildren} = 
        lists:foldl(fun(V, {AccSum, AccComponents}) ->
            if V == P ->
                {AccSum, AccComponents};
            true ->
                {ChildSum, ChildComponents} = dfs(V, U, Adj, ValuesArr, K),
                {AccSum + ChildSum, AccComponents + ChildComponents}
            end
        end, {0, 0}, Children),

    TotalSubtreeSum = NodeValue + SubtreeSumFromChildren,

    if TotalSubtreeSum rem K == 0 ->
        {0, ComponentsFromChildren + 1};
    true ->
        {TotalSubtreeSum, ComponentsFromChildren}
    end.

max_k_divisible_components(Values, Edges, K) ->
    Adj = lists:foldl(fun([U, V], AccAdj) ->
        Adj1 = maps:update_with(U, fun(L) -> [V|L] end, [V], AccAdj),
        maps:update_with(V, fun(L) -> [U|L] end, [U], Adj1)
    end, maps:new(), Edges),

    ValuesArr = array:from_list(Values),

    {_FinalSum, TotalComponents} = dfs(0, -1, Adj, ValuesArr, K),

    TotalComponents.