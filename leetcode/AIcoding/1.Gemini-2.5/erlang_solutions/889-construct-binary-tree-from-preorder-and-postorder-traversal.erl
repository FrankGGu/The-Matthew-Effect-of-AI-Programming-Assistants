-module(solution).
-export([constructFromPrePost/2]).

constructFromPrePost([], []) -> nil;
constructFromPrePost([RootVal], [RootVal]) -> {node, RootVal, nil, nil};
constructFromPrePost([RootVal | PreRest], Postorder) ->
    LeftRootVal = hd(PreRest),
    {PostSubtrees, _} = lists:split(length(Postorder) - 1, Postorder),
    LeftSubtreeLen = find_len_left_subtree(LeftRootVal, PostSubtrees),
    {LeftPre, RightPre} = lists:splitat(LeftSubtreeLen, PreRest),
    {LeftPost, RightPost} = lists:splitat(LeftSubtreeLen, PostSubtrees),
    LeftChild = constructFromPrePost(LeftPre, LeftPost),
    RightChild = constructFromPrePost(RightPre, RightPost),
    {node, RootVal, LeftChild, RightChild}.

find_len_left_subtree(LeftRootVal, PostorderSublist) ->
    find_len_left_subtree(LeftRootVal, PostorderSublist, 0).

find_len_left_subtree(LeftRootVal, [H|T], Acc) when H =:= LeftRootVal ->
    Acc + 1;
find_len_left_subtree(LeftRootVal, [_|T], Acc) ->
    find_len_left_subtree(LeftRootVal, T, Acc + 1).