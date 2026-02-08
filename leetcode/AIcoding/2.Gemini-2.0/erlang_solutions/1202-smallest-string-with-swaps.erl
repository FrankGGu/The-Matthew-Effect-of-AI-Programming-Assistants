-module(smallest_string_with_swaps).
-export([smallest_string_with_swaps/2]).

smallest_string_with_swaps(S, Pairs) ->
    N = length(S),
    UF = uf_init(N),
    lists:foreach(fun([A, B]) -> uf_union(UF, A, B) end, Pairs),
    Groups = group_by_root(UF, lists:seq(0, N - 1)),
    SortedGroups = lists:map(fun({Root, Indices}) ->
        StringIndices = lists:map(fun(I) -> list_to_integer(string:substr(S, I + 1, 1)) end, Indices),
        SortedStringIndices = lists:sort(StringIndices),
        {Root, Indices, SortedStringIndices}
    end, Groups),
    ResultList = lists:duplicate(N, 0),
    lists:foreach(fun({_, Indices, SortedStringIndices}) ->
        lists:zipwith(fun(Index, Char) ->
            lists:nth(Index + 1, lists:seq(1, N)) ! Char
        end, Indices, SortedStringIndices)
    end, SortedGroups),

    lists:foldl(fun(I, Acc) ->
        receive
            Char -> [integer_to_list(Char) | Acc]
        end
    end, [], lists:seq(1, N)),
    list_to_binary(lists:reverse(lists:flatten(lists:reverse(lists:foldl(fun(I, Acc) ->
        receive
            Char -> [integer_to_list(Char) | Acc]
        end
    end, [], lists:seq(1, N))))).

uf_init(N) ->
    [{I, I} || I <- lists:seq(0, N - 1)].

uf_find(UF, X) ->
    case lists:keyfind(X, 1, UF) of
        {_, X} -> X;
        _ -> uf_find(UF, lists:keyfind(X, 1, UF))
    end.

uf_union(UF, A, B) ->
    RootA = uf_find(UF, A),
    RootB = uf_find(UF, B),
    if RootA == RootB then
        UF
    else
        lists:keyreplace(RootB, 1, UF, {RootB, RootA})
    end.

group_by_root(UF, Indices) ->
    lists:foldl(fun(Index, Acc) ->
        Root = uf_find(UF, Index),
        case lists:keyfind(Root, 1, Acc) of
            false -> [{Root, [Index]} | Acc];
            {Root, ExistingIndices} -> lists:keyreplace(Root, 1, Acc, {Root, [Index | ExistingIndices]})
        end
    end, [], Indices).