%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec merge_k_lists(Lists :: [#list_node{} | null]) -> #list_node{} | null.
merge_k_lists(Lists) ->
    merge_k_lists(Lists, []).

merge_k_lists([], Acc) -> reverse(Acc);
merge_k_lists([null | Tail], Acc) -> merge_k_lists(Tail, Acc);
merge_k_lists([Head | Tail], Acc) -> 
    merge_k_lists(Tail, insert_sorted(Acc, Head)).

-spec insert_sorted(Acc :: [#list_node{}], Node :: #list_node{}) -> [#list_node{}].
insert_sorted([], Node) -> [Node];
insert_sorted([#list_node{val = Val} = Head | Tail], #list_node{val = NVal}) when NVal <= Val -> 
    [#list_node{val = NVal, next = Head} | Tail];
insert_sorted([Head | Tail], Node) -> [Head | insert_sorted(Tail, Node)].
