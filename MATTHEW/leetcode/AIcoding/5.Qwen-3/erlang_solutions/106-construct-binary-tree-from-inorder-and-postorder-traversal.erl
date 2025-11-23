-module(solution).
-export([build_tree/2]).

build_tree(Inorder, Postorder) ->
    build_tree(Inorder, Postorder, 0, length(Inorder) - 1, 0, length(Postorder) - 1).

build_tree(_Inorder, _Postorder, IStart, IEnd, PStart, PEnd) when IStart > IEnd ->
    nil;

build_tree(Inorder, Postorder, IStart, IEnd, PStart, PEnd) ->
    RootVal = lists:nth(PEnd + 1, Postorder),
    RootIndex = find_index(Inorder, RootVal, IStart, IEnd),
    LeftSize = RootIndex - IStart,
    LeftSubtree = build_tree(Inorder, Postorder, IStart, RootIndex - 1, PStart, PStart + LeftSize - 1),
    RightSubtree = build_tree(Inorder, Postorder, RootIndex + 1, IEnd, PStart + LeftSize, PEnd - 1),
    {RootVal, LeftSubtree, RightSubtree}.

find_index(List, Val, Start, End) ->
    find_index(List, Val, Start, End, Start).

find_index(_, _, _, End, Index) when Index > End ->
    -1;

find_index(List, Val, Start, End, Index) ->
    if
        lists:nth(Index + 1, List) == Val ->
            Index;
        true ->
            find_index(List, Val, Start, End, Index + 1)
    end.