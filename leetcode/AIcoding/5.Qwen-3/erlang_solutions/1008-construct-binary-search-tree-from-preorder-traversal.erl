-module(bst_from_preorder).
-export([bst_from_preorder/1]).

bst_from_preorder(Preorder) ->
    build_tree(Preorder, 0, length(Preorder) - 1).

build_tree(_, _, L) when L < 0 -> null;
build_tree(Preorder, Start, End) ->
    RootVal = lists:nth(Start + 1, Preorder),
    {LeftEnd, RightStart} = find_left_right(Preorder, Start + 1, End, RootVal),
    Left = build_tree(Preorder, Start + 1, LeftEnd),
    Right = build_tree(Preorder, RightStart, End),
    {RootVal, Left, Right}.

find_left_right(_, _, End, _) when End < 0 -> {End, End + 1};
find_left_right(Preorder, Index, End, RootVal) ->
    if
        Index > End -> {Index - 1, Index};
        lists:nth(Index + 1, Preorder) < RootVal ->
            find_left_right(Preorder, Index + 1, End, RootVal);
        true ->
            {Index - 1, Index}
    end.