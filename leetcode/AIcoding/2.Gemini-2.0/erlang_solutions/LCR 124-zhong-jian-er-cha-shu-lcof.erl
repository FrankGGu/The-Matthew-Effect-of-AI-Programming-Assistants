-module(solution).
-export([build_tree/2]).

build_tree(Inorder, Postorder) ->
    build_tree(Inorder, 0, length(Inorder) - 1, Postorder, 0, length(Postorder) - 1).

build_tree(Inorder, InStart, InEnd, Postorder, PostStart, PostEnd) ->
    if
        InStart > InEnd ->
            null;
        true ->
            RootVal = lists:nth(PostEnd + 1, Postorder),
            RootIndex = find_index(Inorder, InStart, InEnd, RootVal),
            LeftSize = RootIndex - InStart,
            LeftInStart = InStart,
            LeftInEnd = RootIndex - 1,
            LeftPostStart = PostStart,
            LeftPostEnd = PostStart + LeftSize - 1,
            RightInStart = RootIndex + 1,
            RightInEnd = InEnd,
            RightPostStart = PostStart + LeftSize,
            RightPostEnd = PostEnd - 1,
            {RootVal, build_tree(Inorder, LeftInStart, LeftInEnd, Postorder, LeftPostStart, LeftPostEnd),
                      build_tree(Inorder, RightInStart, RightInEnd, Postorder, RightPostStart, RightPostEnd)}
    end.

find_index(List, Start, End, Val) ->
    find_index(List, Start, End, Val, Start).

find_index(List, Start, End, Val, Index) ->
    if
        Index > End ->
            -1;
        lists:nth(Index + 1, List) == Val ->
            Index;
        true ->
            find_index(List, Start, End, Val, Index + 1)
    end.