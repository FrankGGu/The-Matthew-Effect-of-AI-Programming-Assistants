-module(solution).
-export([build_tree/2]).

build_tree(_, []) -> nil;
build_tree([H|T], Post) ->
    Root = H,
    Index = lists:member(Root, Post),
    if
        Index == false -> nil;
        true ->
            LeftPost = lists:sublist(Post, Index - 1),
            RightPost = lists:tl(lists:sublist(Post, Index, length(Post) - Index)),
            LeftSize = length(LeftPost),
            LeftPre = lists:sublist(T, LeftSize),
            RightPre = lists:tl(lists:sublist(T, LeftSize + 1)),
            Left = build_tree(LeftPre, LeftPost),
            Right = build_tree(RightPre, RightPost),
            {Root, Left, Right}
    end.