-module(construct_bst).
-export([bstFromPreorder/1]).

bstFromPreorder(Preorder) ->
    bstFromPreorder(Preorder, -1001, 1001).

bstFromPreorder([], _, _) ->
    nil;
bstFromPreorder([Root | Rest], LowerBound, UpperBound) ->
    if
        Root > LowerBound andalso Root < UpperBound ->
            {Left, Remaining} = split(Rest, Root, LowerBound, UpperBound),
            {Right, Tail} = split(Remaining, Root, Root, UpperBound),
            {tree, Root, Left, Right};
        true ->
            nil
    end.

split([], _, _, _) ->
    {nil, []};

split([H | T], Root, LowerBound, UpperBound) ->
    if
        H > LowerBound andalso H < Root ->
            {Left, Remaining} = split(T, Root, LowerBound, Root),
            {tree, H, Left, Remaining};
        true ->
            {nil, [H | T]}
    end.