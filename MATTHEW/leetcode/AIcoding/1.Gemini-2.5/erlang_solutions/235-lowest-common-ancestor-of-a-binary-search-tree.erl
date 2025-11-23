-module(solution).
-export([lowestCommonAncestor/3]).

lowestCommonAncestor(Root, P, Q) ->
    {RootVal, RootLeft, RootRight} = Root,
    {PVal, _, _} = P,
    {QVal, _, _} = Q,

    if
        PVal < RootVal andalso QVal < RootVal ->
            lowestCommonAncestor(RootLeft, P, Q);
        PVal > RootVal andalso QVal > RootVal ->
            lowestCommonAncestor(RootRight, P, Q);
        true ->
            Root
    end.