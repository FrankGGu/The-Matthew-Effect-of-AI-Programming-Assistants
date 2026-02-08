%% Definition for singly-linked list.
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec sorted_list_to_bst(Head :: #list_node{} | null) -> #tree_node{} | null.
sorted_list_to_bst(Head) ->
    List = to_list(Head),
    sorted_list_to_bst(List).

-spec sorted_list_to_bst(List :: [integer()]) -> #tree_node{} | null.
sorted_list_to_bst([]) -> null;
sorted_list_to_bst([H | T]) ->
    {Left, Right} = split_list(T),
    #tree_node{val = H, left = sorted_list_to_bst(Left), right = sorted_list_to_bst(Right)}.

-spec split_list(List :: [integer()]) -> {[integer()], [integer()]}.
split_list(List) ->
    Half = length(List) div 2,
    {lists:sublist(List, 0, Half), lists:sublist(List, Half, length(List))}.

-spec to_list(Head :: #list_node{} | null) -> [integer()].
to_list(null) -> [];
to_list(#list_node{val = Val, next = Next}) -> [Val | to_list(Next)].
