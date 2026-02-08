-module(delete_middle_node).
-export([deleteMiddle/1]).

-record(list_node, {val, next}).

deleteMiddle(#list_node{next = nil}) -> nil;
deleteMiddle(Head) ->
    {_, Mid} = find_middle(Head, Head),
    delete_node(Head, Mid).

find_middle(Fast, Slow) when Fast#list_node.next == nil ->
    {Slow, Slow};
find_middle(Fast, Slow) ->
    NextFast = Fast#list_node.next,
    NextSlow = Slow#list_node.next,
    if
        NextFast#list_node.next == nil ->
            {NextSlow, NextSlow};
        true ->
            find_middle(NextFast#list_node.next, NextSlow)
    end.

delete_node(Prev, Node) when Prev#list_node.next == Node ->
    Prev#list_node{next = Node#list_node.next};
delete_node(Prev, Node) ->
    delete_node(Prev#list_node.next, Node).