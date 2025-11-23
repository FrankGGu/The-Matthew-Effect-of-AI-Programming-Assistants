-module(split_linked_list_in_parts).
-export([splitListToParts/1]).

-record(list_node, {val, next}).

splitListToParts(Head) ->
    Count = count_nodes(Head),
    Parts = lists:seq(1, Count),
    split_list(Head, Parts, []).

count_nodes(null) -> 0;
count_nodes(#list_node{next = Next}) ->
    1 + count_nodes(Next).

split_list(_Head, [], Result) ->
    lists:reverse(Result);
split_list(Head, [N | Rest], Result) ->
    {NewHead, NewTail} = split_part(Head, N),
    split_list(NewTail, Rest, [NewHead | Result]).

split_part(Node, 0) -> {null, Node};
split_part(Node, N) ->
    #list_node{val = Val, next = Next} = Node,
    {SubHead, SubTail} = split_part(Next, N - 1),
    {#list_node{val = Val, next = SubHead}, SubTail}.