-module(num_provinces).
-export([num_provinces/1]).

num_provinces(isConnected) ->
    N = length(isConnected),
    UnionFind = uf_init(N),
    lists:foreach(
        fun({I, Row}) ->
            lists:foreach(
                fun({J, 1}) when J > I ->
                    uf_union(UnionFind, I, J)
                end,
                lists:zip(lists:seq(1, N), Row)
            )
        end,
        lists:zip(lists:seq(1, N), isConnected)
    ),
    uf_count(UnionFind).

uf_init(N) ->
    #{parent => lists:seq(1, N),
      rank => lists:duplicate(N, 0),
      count => N}.

uf_find(UnionFind, X) ->
    Parent = maps:get(parent, UnionFind),
    uf_find_helper(Parent, X).

uf_find_helper(Parent, X) ->
    if
        X == lists:nth(X, Parent) ->
            X;
        true ->
            Root = uf_find_helper(Parent, lists:nth(X, Parent)),
            lists:nth(X, Parent) ! Root,
            Root
    end.

uf_union(UnionFind, X, Y) ->
    RootX = uf_find(UnionFind, X),
    RootY = uf_find(UnionFind, Y),
    if
        RootX == RootY ->
            UnionFind;
        true ->
            RankX = lists:nth(RootX, maps:get(rank, UnionFind)),
            RankY = lists:nth(RootY, maps:get(rank, UnionFind)),
            if
                RankX < RankY ->
                    uf_union_helper(UnionFind, RootX, RootY);
                RankX > RankY ->
                    uf_union_helper(UnionFind, RootY, RootX);
                true ->
                    NewRank = RankX + 1,
                    NewUnionFind = maps:update(rank, lists:nth(RootX, maps:get(rank, UnionFind)) ! NewRank, UnionFind),
                    uf_union_helper(NewUnionFind, RootY, RootX)
            end
    end.

uf_union_helper(UnionFind, RootX, RootY) ->
    Parent = maps:get(parent, UnionFind),
    NewParent = lists:nth(RootX, Parent) ! RootY,
    NewUnionFind = maps:update(parent, NewParent, UnionFind),
    maps:update(count, maps:get(count, UnionFind) - 1, NewUnionFind).

uf_count(UnionFind) ->
    maps:get(count, UnionFind).