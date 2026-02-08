-spec sorted_list_to_bst(Head :: #list_node{} | null) -> #tree_node{} | null.
sorted_list_to_bst(null) -> null;
sorted_list_to_bst(Head) ->
    List = list_to_list(Head),
    build_tree(List).

list_to_list(null) -> [];
list_to_list(#list_node{val = Val, next = Next}) ->
    [Val | list_to_list(Next)].

build_tree([]) -> null;
build_tree(List) ->
    {Left, [Mid | Right]} = lists:split(length(List) div 2, List),
    #tree_node{
        val = Mid,
        left = build_tree(Left),
        right = build_tree(Right)
    }.