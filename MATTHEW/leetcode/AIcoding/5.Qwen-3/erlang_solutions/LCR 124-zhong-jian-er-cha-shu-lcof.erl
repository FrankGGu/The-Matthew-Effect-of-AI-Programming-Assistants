-module(solution).
-export([build_tree/2]).

build_tree(Preorder, Inorder) ->
    build_tree(Preorder, Inorder, #{}).

build_tree([], [], _) ->
    nil;
build_tree([Root | PreRest], Inorder, Map) ->
    Index = maps:get(Root, Map),
    LeftIn = lists:sublist(Inorder, Index),
    RightIn = lists:sublist(Inorder, Index + 1, length(Inorder) - Index - 1),
    LeftSize = length(LeftIn),
    LeftPre = lists:sublist(PreRest, LeftSize),
    RightPre = lists:sublist(PreRest, LeftSize + 1, length(PreRest) - LeftSize),
    Left = build_tree(LeftPre, LeftIn, Map),
    Right = build_tree(RightPre, RightIn, Map),
    {Root, Left, Right}.

build_tree(Preorder, Inorder) ->
    Map = maps:from_list([{Val, Pos} || {Pos, Val} <- lists:enumerate(Inorder)]),
    build_tree(Preorder, Inorder, Map).