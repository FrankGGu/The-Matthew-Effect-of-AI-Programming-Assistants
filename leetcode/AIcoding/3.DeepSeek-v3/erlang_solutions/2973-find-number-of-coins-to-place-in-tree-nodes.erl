-module(solution).
-export([number_of_coins/2]).

number_of_coins(Edges, Cost) ->
    N = length(Cost),
    Tree = build_tree(Edges, N),
    {Total, _} = dfs(0, -1, Tree, Cost),
    Total.

build_tree(Edges, N) ->
    Tree = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
        update_tree(Acc, U, V)
    end, Tree, Edges).

update_tree(Tree, U, V) ->
    Tree1 = setelement(U + 1, Tree, [V | element(U + 1, Tree)]),
    setelement(V + 1, Tree1, [U | element(V + 1, Tree1)]).

dfs(Node, Parent, Tree, Cost) ->
    Children = [Child || Child <- element(Node + 1, Tree), Child =/= Parent],
    {SumChildren, MaxChild} = lists:foldl(fun(Child, {Sum, Max}) ->
        {SumC, MaxC} = dfs(Child, Node, Tree, Cost),
        {Sum + SumC, max(Max, MaxC)}
    end, {0, 0}, Children),
    Current = lists:nth(Node + 1, Cost),
    if
        Current > MaxChild ->
            {SumChildren + Current, Current};
        true ->
            {SumChildren + MaxChild, MaxChild}
    end.