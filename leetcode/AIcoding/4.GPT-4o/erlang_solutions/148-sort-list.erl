%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec sort_list(Head :: #list_node{} | null) -> #list_node{} | null.
sort_list(null) -> null;
sort_list(Head) ->
    merge_sort(Head).

-spec merge_sort(Head :: #list_node{} | null) -> #list_node{} | null.
merge_sort(null) -> null;
merge_sort(#list_node{next = null}) -> null;
merge_sort(Head) ->
    {Left, Right} = split_list(Head),
    LeftSorted = merge_sort(Left),
    RightSorted = merge_sort(Right),
    merge(LeftSorted, RightSorted).

-spec split_list(Head :: #list_node{} | null) -> {#list_node{}, #list_node{}}.
split_list(Head) ->
    split_list(Head, Head, null).

split_list(null, _, _) -> {null, null};
split_list(#list_node{next = null}, _, _) -> {null, null};
split_list(#list_node{next = Next} = Head, #list_node{next = NextNext} = Fast, Slow) ->
    split_list(Next, NextNext, Head).

-spec merge(Left :: #list_node{} | null, Right :: #list_node{} | null) -> #list_node{} | null.
merge(null, Right) -> Right;
merge(Left, null) -> Left;
merge(#list_node{val = LVal, next = LNext}, #list_node{val = RVal, next = RNext}) when LVal < RVal ->
    #list_node{val = LVal, next = merge(LNext, #list_node{val = RVal, next = RNext})};
merge(#list_node{val = LVal, next = LNext}, #list_node{val = RVal, next = RNext}) ->
    #list_node{val = RVal, next = merge(#list_node{val = LVal, next = LNext}, RNext)}.
