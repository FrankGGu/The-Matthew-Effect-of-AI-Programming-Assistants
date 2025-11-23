-module(merge_in_between_linked_lists).
-export([mergeInBetween/2]).

-record(list_node, {val, next}).

mergeInBetween(#list_node{val = L_val, next = L_next}, #list_node{val = R_val, next = R_next}) ->
    merge_in_between(L_next, R_next, L_val, R_val, 0, 0).

merge_in_between(L, R, L_val, R_val, L_count, R_count) when L_count == 1, R_count == 1 ->
    #list_node{val = L_val, next = R};
merge_in_between(L, R, L_val, R_val, L_count, R_count) when L_count == 1 ->
    #list_node{val = L_val, next = merge_in_between(L, R_next, L_val, R_val, 0, R_count + 1)};
merge_in_between(L, R, L_val, R_val, L_count, R_count) when R_count == 1 ->
    #list_node{val = R_val, next = merge_in_between(L_next, R, L_val, R_val, L_count + 1, 0)};
merge_in_between(L, R, L_val, R_val, L_count, R_count) ->
    #list_node{val = L_val, next = merge_in_between(L_next, R, L_val, R_val, L_count + 1, R_count)}.