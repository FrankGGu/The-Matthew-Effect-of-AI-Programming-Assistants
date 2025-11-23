-module(nary_preorder).
-export([preorder/1]).

-type node() :: #{val := integer(), children := [node()]}.

preorder(Root) ->
    preorder_helper(Root, []).

preorder_helper(null, Acc) ->
    lists:reverse(Acc);
preorder_helper(#{val := Val, children := Children}, Acc) ->
    NewAcc = [Val | Acc],
    preorder_children(Children, NewAcc).

preorder_children([], Acc) ->
    lists:reverse(Acc);
preorder_children([Child | Rest], Acc) ->
    NewAcc = preorder_helper(Child, Acc),
    preorder_children(Rest, NewAcc).