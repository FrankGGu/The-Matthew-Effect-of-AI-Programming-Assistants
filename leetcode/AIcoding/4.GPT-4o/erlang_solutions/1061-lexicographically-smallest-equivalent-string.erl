-module(solution).
-export([smallestEquivalentString/3]).

smallestEquivalentString(S, A, B) ->
    UnionFind = init_union_find(),
    UnionFind1 = union(UnionFind, A, B),
    Result = [find(UnionFind1, Ch) || Ch <- S],
    lists:flatten(Result).

init_union_find() ->
    lists:duplicate(26, none).

union(UnionFind, A, B) ->
    RootA = find(UnionFind, A),
    RootB = find(UnionFind, B),
    case {RootA, RootB} of
        {none, none} ->
            UnionFind;
        {none, _} ->
            set(UnionFind, A, RootB);
        {_, none} ->
            set(UnionFind, B, RootA);
        {RootA, RootB} when RootA =/= RootB ->
            set(UnionFind, RootA, RootB);
        _ ->
            UnionFind
    end.

find(UnionFind, Ch) ->
    Index = Ch - $a,
    case lists:nth(Index + 1, UnionFind) of
        none -> Ch;
        Root -> find(UnionFind, Root)
    end.

set(UnionFind, Ch, Root) ->
    Index = Ch - $a,
    lists:replace(Index + 1, Root, UnionFind).