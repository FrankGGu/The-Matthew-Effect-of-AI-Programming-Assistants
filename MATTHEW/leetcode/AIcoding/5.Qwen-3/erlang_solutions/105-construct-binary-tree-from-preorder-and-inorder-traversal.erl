-module(solution).
-export([build_tree/2]).

build_tree([], []) -> nil;
build_tree(Preorder, Inorder) ->
    [Root | RestPre] = Preorder,
    {LeftIn, [Root | RightIn]} = lists:split(lists:member(Root, Inorder), Inorder),
    LeftSize = length(LeftIn),
    {LeftPre, RightPre} = lists:split(LeftSize, RestPre),
    Left = build_tree(LeftPre, LeftIn),
    Right = build_tree(RightPre, RightIn),
    {Root, Left, Right}.