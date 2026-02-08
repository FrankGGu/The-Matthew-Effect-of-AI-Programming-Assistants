-module(solution).
-export([insert_into_max_tree/2]).

-record(node, {val, left = none, right = none}).

insert_into_max_tree(Root, Val) ->
    NewNode = #node{val = Val},
    case insert(Root, NewNode) of
        none -> NewNode;
        _ -> insert(Root, NewNode)
    end.

insert(none, NewNode) -> NewNode;
insert(#node{val=Val, left=Left, right=Right} = Root, NewNode) when NewNode#node.val > Val ->
    #node{Root | left = NewNode, right = Left};
insert(#node{val=Val, left=Left, right=Right} = Root, NewNode) ->
    #node{Root | right = insert(Right, NewNode)}.