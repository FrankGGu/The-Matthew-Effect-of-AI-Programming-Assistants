-module(sorted_list_to_bst).
-export([sorted_list_to_bst/1]).

-record(list_node, {val, next}).

sorted_list_to_bst(Head) ->
    Len = list_length(Head),
    {_, Root} = build_bst(Head, 1, Len),
    Root.

list_length(Head) ->
    list_length(Head, 0).

list_length(null, Acc) ->
    Acc;
list_length(Head, Acc) ->
    list_length(Head#list_node.next, Acc + 1).

build_bst(Head, Start, End) ->
    if Start > End ->
        {Head, null};
    true ->
        Mid = (Start + End) div 2,
        {HeadLeft, Left} = build_bst(Head, Start, Mid - 1),
        Val = HeadLeft#list_node.val,
        NextHead = HeadLeft#list_node.next,
        {HeadRight, Right} = build_bst(NextHead, Mid + 1, End),
        Root = {tree, Val, Left, Right},
        {HeadRight, Root}
    end.