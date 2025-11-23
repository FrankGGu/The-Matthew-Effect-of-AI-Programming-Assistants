-module(graph_connectivity_with_threshold).
-export([are_connected/4]).

are_connected(N, threshold, Queries, U) ->
    Parent = lists:seq(1, N),
    Rank = lists:seq(1, N),
    UnionFind = {Parent, Rank},
    {UnionFindAfter, _} = lists:foldl(fun({a, b}, {UF, _}) -> union(UF, a, b) end, UnionFind, U),
    lists:map(fun({a, b}) -> find(UnionFindAfter, a) == find(UnionFindAfter, b) end, Queries).

union({Parent, Rank}, a, b) ->
    RootA = find({Parent, Rank}, a),
    RootB = find({Parent, Rank}, b),
    if
        RootA == RootB -> {Parent, Rank};
        true ->
            case lists:nth(RootA, Rank) >= lists:nth(RootB, Rank) of
                true ->
                    NewParent = lists:sublist(Parent, RootB, 1) ++ lists:sublist(Parent, RootB + 1, length(Parent) - RootB),
                    NewRank = lists:sublist(Rank, RootA, 1) ++ [lists:nth(RootA, Rank) + lists:nth(RootB, Rank)],
                    {NewParent, NewRank};
                false ->
                    NewParent = lists:sublist(Parent, RootA, 1) ++ lists:sublist(Parent, RootA + 1, length(Parent) - RootA),
                    NewRank = lists:sublist(Rank, RootB, 1) ++ [lists:nth(RootA, Rank) + lists:nth(RootB, Rank)],
                    {NewParent, NewRank}
            end
    end.

find({Parent, _}, x) ->
    if
        lists:nth(x, Parent) == x -> x;
        true ->
            Root = find({Parent, _}, lists:nth(x, Parent)),
            NewParent = lists:sublist(Parent, x, 1) ++ [Root],
            {NewParent, _}
    end.