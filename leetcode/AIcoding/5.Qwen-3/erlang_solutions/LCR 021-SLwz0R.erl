-module(remove_nth_node_from_end).
-export([remove_nth_from_end/2]).

-record(list_node, {val, next}).

remove_nth_from_end(undefined, _) -> undefined;
remove_nth_from_end(Node, N) ->
    {Length, _} = count_nodes(Node, 0),
    remove_nth(Node, Length - N + 1, 1).

count_nodes(undefined, Acc) -> {Acc, undefined};
count_nodes(#list_node{next = Next}, Acc) ->
    count_nodes(Next, Acc + 1).

remove_nth(undefined, _, _) -> undefined;
remove_nth(Node, Target, Index) when Index == Target ->
    Node#list_node.next;
remove_nth(Node, Target, Index) ->
    #list_node{
        val = Node#list_node.val,
        next = remove_nth(Node#list_node.next, Target, Index + 1)
    }.