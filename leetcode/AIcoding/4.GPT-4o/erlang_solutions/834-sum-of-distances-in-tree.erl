-module(solution).
-export([sum_of_distances_in_tree/2]).

sum_of_distances_in_tree(N, Edges) ->
    Tree = build_tree(N, Edges),
    {Count, Distances} = dfs(0, Tree, -1),
    lists:map(fun(X) -> distances_sum(X, Count, Distances) end, lists:seq(0, N - 1)).

build_tree(N, Edges) ->
    Tree = lists:foldl(fun({X, Y}, Acc) -> 
        lists:keystore(X, 1, Acc, [{X, []}]), 
        lists:keystore(Y, 1, Acc, [{Y, []}]), 
        Acc#lists.keyreplace(X, 1, Acc, [{X, Y} | lists:keyfind(X, 1, Acc)}]), 
        Acc#lists.keyreplace(Y, 1, Acc, [{Y, X} | lists:keyfind(Y, 1, Acc)}])
    end, lists:duplicate(N, []), Edges),
    lists:map(fun({K, V}) -> {K, lists:sort(V)} end, Tree).

dfs(Node, Tree, Parent) ->
    {Count, Distances} = lists:foldl(fun(Child, {C, D}) -> 
        if 
            Child =:= Parent -> {C, D}; 
            true -> 
                {ChildCount, ChildDistances} = dfs(Child, Tree, Node),
                {C + ChildCount, D + ChildDistances + ChildCount}
        end
    end, {1, 0}, lists:keyfind(Node, 1, Tree)),
    {Count, Distances}.

distances_sum(Node, Count, Distances) ->
    Distances + (Count - lists:keyfind(Node, 1, Count)).