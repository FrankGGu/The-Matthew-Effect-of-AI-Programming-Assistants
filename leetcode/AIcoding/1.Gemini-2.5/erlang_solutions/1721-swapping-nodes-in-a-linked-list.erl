-module(solution).
-export([swap_nodes/2]).

-record(list_node, {val, next}).

get_nth_node(Head, N) ->
    get_nth_node(Head, N, 1).

get_nth_node(#list_node{val=Val, next=Next}, N, N) ->
    #list_node{val=Val, next=Next};
get_nth_node(#list_node{next=Next}, N, Current) ->
    get_nth_node(Next, N, Current + 1);
get_nth_node(nil, _, _) ->
    nil.

list_length(nil) -> 0;
list_length(#list_node{next=Next}) -> 1 + list_length(Next).

swap_nodes(Head, K) ->
    Len = list_length(Head),
    KthFromEnd = Len - K + 1,

    NodeK = get_nth_node(Head, K),
    NodeKthFromEnd = get_nth_node(Head, KthFromEnd),

    ValK_original = NodeK#list_node.val,
    ValKthFromEnd_original = NodeKthFromEnd#list_node.val,

    rebuild_list(Head, K, KthFromEnd, ValKthFromEnd_original, ValK_original, 1).

rebuild_list(nil, _, _, _, _, _) ->
    nil;
rebuild_list(#list_node{val=_OldVal, next=Next}, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current) when Current == K ->
    #list_node{val=ValToSetAtK, next=rebuild_list(Next, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current + 1)};
rebuild_list(#list_node{val=_OldVal, next=Next}, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current) when Current == KthFromEnd ->
    #list_node{val=ValToSetAtKthFromEnd, next=rebuild_list(Next, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current + 1)};
rebuild_list(#list_node{val=Val, next=Next}, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current) ->
    #list_node{val=Val, next=rebuild_list(Next, K, KthFromEnd, ValToSetAtK, ValToSetAtKthFromEnd, Current + 1)}.