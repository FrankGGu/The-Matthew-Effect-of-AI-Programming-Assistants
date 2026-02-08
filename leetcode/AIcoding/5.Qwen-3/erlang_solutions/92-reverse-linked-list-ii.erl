-module(reverse_linked_list_ii).
-export([reverse_between/3]).

-record(list_node, {val, next}).

reverse_between(Head, Left, Right) ->
    reverse(Head, Left, Right, 1, undefined, undefined).

reverse(undefined, _, _, _, _, _) ->
    undefined;

reverse(Node, Left, Right, Pos, Prev, Next) ->
    case Pos of
        Left when Pos == Left ->
            reverse(Node#list_node.next, Left, Right, Pos + 1, Node, Node);
        _ when Pos < Right ->
            NextNode = Node#list_node.next,
            Node#list_node{next = Prev},
            reverse(NextNode, Left, Right, Pos + 1, Node, Next);
        _ when Pos == Right ->
            Node#list_node{next = Prev},
            if
                Prev == undefined -> Node;
                true -> Node#list_node{next = Next}
            end;
        _ ->
            Node
    end.