-module(solution).
-export([merge_k_lists/1]).

-record(list_node, {val, next}).

merge_k_lists([]) ->
    nil;
merge_k_lists([H | T]) ->
    merge_k_lists(H, T).

merge_k_lists(Head, []) ->
    Head;
merge_k_lists(Head, [H | T]) ->
    NewHead = merge_two_lists(Head, H),
    merge_k_lists(NewHead, T).

merge_two_lists(nil, L2) ->
    L2;
merge_two_lists(L1, nil) ->
    L1;
merge_two_lists(#list_node{val = V1, next = N1}, #list_node{val = V2, next = N2}) ->
    if
        V1 =< V2 ->
            #list_node{val = V1, next = merge_two_lists(N1, #list_node{val = V2, next = N2})};
        true ->
            #list_node{val = V2, next = merge_two_lists(#list_node{val = V1, next = N1}, N2)}
    end.