-module(min_cost_to_connect_all_points).
-export([min_cost/1]).

min_cost(Points) ->
    N = length(Points),
    Edges = lists:flatmap(fun({X1, Y1}) ->
                                lists:map(fun({X2, Y2}) -> {abs(X1 - X2) + abs(Y1 - Y2), {X1, Y1}, {X2, Y2}} end,
                                            lists:delete({X1, Y1}, Points)
                                )
                            end, Points),
    Kruskal(Edges, N).

Kruskal(Edges, N) ->
    SortedEdges = lists:sort(fun({W1, _, _}, {W2, _, _}) -> W1 =< W2 end, Edges),
    {Parent, Rank} = initialize_sets(N),
    MinimumCost = kruskal_helper(SortedEdges, Parent, Rank, N, 0),
    MinimumCost.

initialize_sets(N) ->
    Parent = lists:seq(0, N - 1),
    Rank = lists:duplicate(N, 0),
    {Parent, Rank}.

find_set(X, Parent) ->
    case lists:keyfind(X, 1, lists:zip(lists:seq(0, length(Parent) - 1), Parent)) of
        {_, P} when P =/= X -> find_set(P, Parent);
        _ -> X
    end.

union(X, Y, Parent, Rank) ->
    RootX = find_set(X, Parent),
    RootY = find_set(Y, Parent),
    case {RootX, RootY} of
        {Rx, Ry} when Rx =/= Ry ->
            if lists:nth(Rx + 1, Rank) < lists:nth(Ry + 1, Rank) ->
                {lists:sublist(Parent, 0, Ry) ++ [Rx] ++ lists:sublist(Parent, Ry + 1, length(Parent) - Ry - 1), Rank};
            lists:nth(Rx + 1, Rank) > lists:nth(Ry + 1, Rank) ->
                {lists:sublist(Parent, 0, Rx) ++ [Ry] ++ lists:sublist(Parent, Rx + 1, length(Parent) - Rx - 1), Rank};
            true ->
                {lists:sublist(Parent, 0, Ry) ++ [Rx] ++ lists:sublist(Parent, Ry + 1, length(Parent) - Ry - 1), lists:map(fun(R) -> if R == Ry -> R + 1; true -> R end end, Rank)}
            end;
        _ -> {Parent, Rank}
    end.

kruskal_helper([], _, _, _, Cost) ->
    Cost;
kruskal_helper([{W, {X1, Y1}, {X2, Y2}} | Edges], Parent, Rank, N, Cost) ->
    RootX = find_set(X1, Parent),
    RootY = find_set(X2, Parent),
    if RootX =/= RootY ->
        NewParent = union(RootX, RootY, Parent, Rank),
        kruskal_helper(Edges, lists:nth(1, NewParent), lists:nth(2, NewParent), N, Cost + W);
    true ->
        kruskal_helper(Edges, Parent, Rank, N, Cost)
    end.