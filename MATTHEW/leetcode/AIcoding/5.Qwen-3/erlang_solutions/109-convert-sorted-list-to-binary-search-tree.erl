-module(convert_sorted_list_to_binary_search_tree).
-export([sorted_list_to_bst/1]).

-record(list_node, {val, next}).
-record(tree_node, {val, left, right}).

sorted_list_to_bst(Head) ->
    List = list_from_linked_list(Head),
    build_tree(List, 1, length(List)).

list_from_linked_list(nil) ->
    [];
list_from_linked_list(#list_node{val=Val, next=Next}) ->
    [Val | list_from_linked_list(Next)].

build_tree(List, Start, End) when Start > End ->
    nil;
build_tree(List, Start, End) ->
    Mid = (Start + End) div 2,
    Left = build_tree(List, Start, Mid - 1),
    Val = lists:nth(Mid, List),
    Right = build_tree(List, Mid + 1, End),
    #tree_node{val=Val, left=Left, right=Right}.