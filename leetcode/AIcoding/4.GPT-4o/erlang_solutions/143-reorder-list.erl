%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec reorder_list(Head :: #list_node{} | null) -> void.
reorder_list(Head) ->
    {Left, Right} = split_list(Head),
    reorder_list(Left, Right).

split_list(Head) ->
    split_list(Head, Head).

split_list(null, _) -> {null, null};
split_list(#list_node{next = null}, _) -> {Head, null};
split_list(#list_node{next = Next}, #list_node{next = NextNext}) ->
    {Left, Right} = split_list(NextNext),
    {#list_node{val = HeadVal, next = Left}, #list_node{val = NextVal, next = Right}}.

reorder_list(Left, Right) ->
    merge(Left, Right).

merge(null, null) -> null;
merge(Left, Right) ->
    #list_node{val = LeftVal, next = merge(Right, Left#list_node{next = null})}.
