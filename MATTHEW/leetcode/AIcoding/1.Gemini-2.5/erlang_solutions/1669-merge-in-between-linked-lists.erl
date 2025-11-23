-module(solution).
-export([merge_in_between/4]).

-record(list_node, {val, next = nil}).

merge_in_between(List1, A, B, List2) ->
    merge_in_between_rec(List1, A, B, List2, 0).

merge_in_between_rec(nil, _, _, _, _) ->
    nil;
merge_in_between_rec(#list_node{val = Val, next = Next}, A, B, List2, CurrentIndex) when CurrentIndex < A ->
    #list_node{val = Val, next = merge_in_between_rec(Next, A, B, List2, CurrentIndex + 1)};
merge_in_between_rec(List1, A, B, List2, CurrentIndex) when CurrentIndex == A ->
    % At the A-th node. Skip B - A + 1 nodes from List1 and use the rest as suffix.
    Suffix = skip_nodes(List1, B - A + 1),
    % Connect List2 to this Suffix.
    connect_list2_to_suffix(List2, Suffix).

skip_nodes(List, 0) ->
    List;
skip_nodes(nil, _) ->
    nil;
skip_nodes(#list_node{next = Next}, N) when N > 0 ->
    skip_nodes(Next, N - 1).

connect_list2_to_suffix(nil, Suffix) ->
    Suffix;
connect_list2_to_suffix(#list_node{val = Val, next = Next}, Suffix) ->
    #list_node{val = Val, next = connect_list2_to_suffix(Next, Suffix)}.