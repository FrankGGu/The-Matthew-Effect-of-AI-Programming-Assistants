-module(solution).
-export([shortest_path/4]).

shortest_path(N, Edges, Q, Queries) ->
    Tree = build_tree(N, Edges),
    {Parents, Depths} = preprocess(Tree, N),
    lists:map(fun([U, V]) -> query(U, V, Parents, Depths, Tree) end, Queries).

build_tree(N, Edges) ->
    Tree = lists:foldl(fun(_, Acc) -> [[]] ++ Acc end, [], lists:seq(1, N)),
    lists:foldl(fun([U, V, W], Acc) ->
                    U1 = U + 1,
                    V1 = V + 1,
                    Acc1 = set_child(U1, {V1, W}, Acc),
                    set_child(V1, {U1, W}, Acc1)
                end, Tree, Edges).

set_child(U, {V, W}, Tree) ->
    Children = lists:nth(U, Tree),
    lists:sublist(Tree, U - 1) ++ [[{V, W} | Children]] ++ lists:nthtail(U, Tree).

preprocess(Tree, N) ->
    Parents = array:new([{size, N + 1}, {default, 0}]),
    Depths = array:new([{size, N + 1}, {default, 0}]),
    Weights = array:new([{size, N + 1}, {default, 0}]),
    {P, D, W} = dfs(1, 0, 0, 0, Tree, Parents, Depths, Weights),
    {P, D}.

dfs(U, Parent, Depth, Weight, Tree, Parents, Depths, Weights) ->
    Parents1 = array:set(U, Parent, Parents),
    Depths1 = array:set(U, Depth, Depths),
    Weights1 = array:set(U, Weight, Weights),
    lists:foldl(fun({V, W}, {PAcc, DAcc, WAcc}) ->
                    case V =/= Parent of
                        true -> dfs(V, U, Depth + 1, W, Tree, PAcc, DAcc, WAcc);
                        false -> {PAcc, DAcc, WAcc}
                    end
                end, {Parents1, Depths1, Weights1}, lists:nth(U, Tree)).

query(U, V, Parents, Depths, Tree) ->
    U1 = U + 1,
    V1 = V + 1,
    LCA = lca(U1, V1, Parents, Depths),
    path_weight(U1, LCA, Parents, Tree) + path_weight(V1, LCA, Parents, Tree).

lca(U, V, Parents, Depths) ->
    if
        Depths(U) > Depths(V) -> lca(Parents(U), V, Parents, Depths);
        Depths(U) < Depths(V) -> lca(U, Parents(V), Parents, Depths);
        true -> 
            if
                U == V -> U;
                true -> lca(Parents(U), Parents(V), Parents, Depths)
            end
    end.

path_weight(U, Ancestor, Parents, Tree) ->
    if
        U == Ancestor -> 0;
        true ->
            Parent = Parents(U),
            Children = lists:nth(Parent, Tree),
            W = find_weight(U, Children),
            W + path_weight(Parent, Ancestor, Parents, Tree)
    end.

find_weight(U, Children) ->
    case lists:keyfind(U, 1, Children) of
        {U, W} -> W;
        false -> 0
    end.