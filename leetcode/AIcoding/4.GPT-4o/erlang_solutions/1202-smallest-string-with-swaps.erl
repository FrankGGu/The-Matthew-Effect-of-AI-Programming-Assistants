-module(solution).
-export([smallest_string_with_swaps/2]).

smallest_string_with_swaps(Str, Pairs) ->
    UnionFind = lists:foldl(fun({X, Y}, UF) -> union(UF, X, Y) end, init_uf(length(Str)), Pairs),
    Groups = group_by_roots(UnionFind),
    SortedStrs = lists:map(fun(G) -> lists:sort(G) end, Groups),
    lists:map(fun(Index) -> hd(lists:nth(Index + 1, SortedStrs)) end, lists:seq(0, length(Str) - 1)).

init_uf(N) -> lists:seq(0, N - 1).

union(UF, X, Y) ->
    RootX = find(UF, X),
    RootY = find(UF, Y),
    if
        RootX =:= RootY -> UF;
        true -> lists:map(fun(Idx) -> if Idx == RootX -> RootY; true -> Idx end end, UF)
    end.

find(UF, X) ->
    case lists:nth(X + 1, UF) of
        X -> X;
        Parent -> find(UF, Parent)
    end.

group_by_roots(UF) ->
    lists:foldl(fun(Index, Acc) ->
        Root = find(UF, Index),
        case lists:keyfind(Root, 1, Acc) of
            false -> [{Root, [Index]} | Acc];
            {Root, Indices} -> [{Root, [Index | Indices]} | lists:keydelete(Root, 1, Acc)]
        end
    end, [], lists:seq(0, length(UF) - 1)).