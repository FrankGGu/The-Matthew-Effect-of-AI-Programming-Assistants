-spec preorder(Root :: #node{} | null) -> [integer()].
preorder(null) -> [];
preorder(Root) ->
    preorder(Root, []).

preorder(null, Acc) -> Acc;
preorder(Node, Acc) ->
    NewAcc = [Node#node.val | Acc],
    Children = lists:reverse(Node#node.children),
    preorder_children(Children, NewAcc).

preorder_children([], Acc) -> Acc;
preorder_children([Child | Rest], Acc) ->
    NewAcc = preorder(Child, Acc),
    preorder_children(Rest, NewAcc).