-module(solution).
-export([smallest_string_with_swaps/2]).

smallest_string_with_swaps(S, Pairs) ->
    N = length(S),
    Parent = lists:seq(0, N - 1),
    lists:foreach(fun([I, J]) -> union(I, J, Parent) end, Pairs),
    Groups = group_indices(Parent, N),
    SortedGroups = lists:map(fun(Indices) -> lists:sort(Indices) end, Groups),
    SortedChars = lists:map(fun(Indices) -> 
                                Chars = [lists:nth(Idx + 1, S) || Idx <- Indices],
                                lists:sort(Chars)
                            end, SortedGroups),
    Result = lists:duplicate(N, 0),
    build_result(SortedGroups, SortedChars, Result, 0).

find(X, Parent) ->
    case lists:nth(X + 1, Parent) of
        X -> X;
        P -> find(P, Parent)
    end.

union(X, Y, Parent) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if
        RootX =/= RootY ->
            Parent2 = setelement(RootX + 1, Parent, RootY),
            Parent2;
        true -> Parent
    end.

group_indices(Parent, N) ->
    Dict = dict:new(),
    Dict2 = lists:foldl(fun(I, Acc) ->
                            Root = find(I, Parent),
                            dict:append(Root, I, Acc)
                        end, Dict, lists:seq(0, N - 1)),
    dict:fold(fun(_, V, Acc) -> [V | Acc] end, [], Dict2).

build_result([], [], Result, _) -> Result;
build_result([Group | Groups], [Chars | CharsList], Result, _) ->
    NewResult = lists:foldl(fun({Idx, Char}, Acc) -> 
                                setelement(Idx + 1, Acc, Char)
                            end, Result, lists:zip(Group, Chars)),
    build_result(Groups, CharsList, NewResult, 0).