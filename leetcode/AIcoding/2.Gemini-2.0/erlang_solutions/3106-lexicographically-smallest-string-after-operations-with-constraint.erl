-module(smallest_string_with_swaps).
-export([smallestStringWithSwaps/2]).

smallestStringWithSwaps(S, Pairs) ->
    N = length(S),
    Parent = lists:seq(0, N - 1),
    Components = create_components(Pairs, Parent),
    Chars = string:to_charlist(S),
    Groups = group_by_component(Chars, Components),
    result(Groups).

create_components(Pairs, Parent) ->
    lists:foldl(fun({A, B}, Acc) ->
                        union(A, B, Acc)
                end, Parent, Pairs).

find(X, Parent) ->
    if X == lists:nth(X + 1, Parent) then
        X
    else
        P = lists:nth(X + 1, Parent),
        Root = find(P, Parent),
        lists:nth(X + 1, Parent) = Root,
        Root
    end.

union(A, B, Parent) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    if RootA =/= RootB then
        lists:nth(RootA + 1, Parent) = RootB,
        Parent
    else
        Parent
    end.

group_by_component(Chars, Parent) ->
    lists:foldl(fun({Char, Index}, Acc) ->
                        Root = find(Index, Parent),
                        case lists:keyfind(Root, 1, Acc) of
                            false ->
                                [{Root, [Char]} | Acc];
                            {Root, CharsInGroup} ->
                                lists:keyreplace(Root, 1, Acc, {Root, [Char | CharsInGroup]})
                        end
                end, [], lists:zip(Chars, lists:seq(0, length(Chars) - 1))).

result(Groups) ->
    SortedGroups = lists:map(fun({Root, Chars}) ->
                                    SortedChars = lists:sort(Chars),
                                    {Root, SortedChars}
                             end, Groups),
    ResultList = lists:map(fun(Index) ->
                                    Root = find(Index, lists:seq(0, length(string:to_charlist(lists:nth(1, hd(SortedGroups)))) - 1)),
                                    {Root, Index}
                             end, lists:seq(0, length(string:to_charlist(lists:nth(1, hd(SortedGroups)))) - 1)),

    lists:foldl(fun({Root, Index}, Acc) ->
                        {_, SortedChars} = lists:keyfind(Root, 1, SortedGroups),
                        case SortedChars of
                            [] ->
                                Acc;
                            _ ->
                                Char = lists:nth(1, SortedChars),
                                {_, NewSortedChars} = lists:keyreplace(Root, 1, SortedGroups, {Root, tl(SortedChars)}),
                                SortedGroups = NewSortedChars,
                                [Char | Acc]
                        end
                end, [], lists:sort(ResultList)),

    list_to_binary(lists:reverse(lists:flatten(lists:map(fun(X) -> [X] end, lists:foldl(fun({Root, Index}, Acc) ->
                        {_, SortedChars} = lists:keyfind(Root, 1, SortedGroups),
                        case SortedChars of
                            [] ->
                                Acc;
                            _ ->
                                Char = lists:nth(1, SortedChars),
                                {_, NewSortedChars} = lists:keyreplace(Root, 1, SortedGroups, {Root, tl(SortedChars)}),
                                SortedGroups = NewSortedChars,
                                [Char | Acc]
                        end
                end, [], lists:sort(ResultList))))).