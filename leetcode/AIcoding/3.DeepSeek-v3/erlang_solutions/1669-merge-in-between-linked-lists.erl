-spec merge_in_between(List1 :: #list_node{} | null, A :: integer(), B :: integer(), List2 :: #list_node{} | null) -> #list_node{} | null.
merge_in_between(List1, A, B, List2) ->
    {BeforeA, AfterB} = find_nodes(List1, A, B),
    LastList2 = get_last(List2),
    BeforeA#list_node{next = List2},
    LastList2#list_node{next = AfterB},
    List1.

find_nodes(List, A, B) ->
    find_nodes(List, 0, A, B, null, null).

find_nodes(null, _Index, _A, _B, BeforeA, AfterB) ->
    {BeforeA, AfterB};
find_nodes(Node, Index, A, B, BeforeA, AfterB) ->
    NextIndex = Index + 1,
    NextNode = Node#list_node.next,
    if
        Index =:= A - 1 ->
            find_nodes(NextNode, NextIndex, A, B, Node, AfterB);
        Index =:= B + 1 ->
            find_nodes(NextNode, NextIndex, A, B, BeforeA, Node);
        true ->
            find_nodes(NextNode, NextIndex, A, B, BeforeA, AfterB)
    end.

get_last(null) ->
    null;
get_last(Node) ->
    case Node#list_node.next of
        null -> Node;
        Next -> get_last(Next)
    end.