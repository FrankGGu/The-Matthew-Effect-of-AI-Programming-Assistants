-module(my_linked_list).
-export([new/0, add_at_head/2, add_at_tail/2, add_at_index/3, delete_at_index/1, get/2]).

-record(node, {value, next = none}).
-record(linked_list, {head = none, size = 0}).

new() ->
    #linked_list{}.

add_at_head(List, Value) ->
    NewNode = #node{value = Value, next = List#linked_list.head},
    Size = List#linked_list.size + 1,
    List#linked_list{head = NewNode, size = Size}.

add_at_tail(List, Value) ->
    NewNode = #node{value = Value},
    add_node(List, NewNode).

add_at_index(List, Index, Value) when Index < 0 ->
    add_at_head(List, Value);
add_at_index(List, Index, Value) when Index >= List#linked_list.size ->
    add_at_tail(List, Value);
add_at_index(List, Index, Value) ->
    NewNode = #node{value = Value},
    add_node_at_index(List, NewNode, Index, 0).

delete_at_index(List, Index) when Index < 0; Index >= List#linked_list.size ->
    List;
delete_at_index(List, Index) ->
    delete_node_at_index(List, Index, 0, none).

get(List, Index) when Index < 0; Index >= List#linked_list.size ->
    -1;
get(List, Index) ->
    get_value(List#linked_list.head, Index, 0).

add_node(List, NewNode) ->
    if
        List#linked_list.head =:= none ->
            List#linked_list{head = NewNode, size = List#linked_list.size + 1};
        true ->
            Head = List#linked_list.head,
            NewHead = add_node_to_tail(Head, NewNode),
            List#linked_list{head = NewHead, size = List#linked_list.size + 1}
    end.

add_node_to_tail(Node, NewNode) ->
    case Node#node.next of
        none ->
            Node#node{next = NewNode};
        Next ->
            Node#node{next = add_node_to_tail(Next, NewNode)}
    end.

add_node_at_index(List, NewNode, Index, CurrentIndex) ->
    case CurrentIndex of
        0 ->
            NewNode#node{next = List#linked_list.head};
        _ ->
            Head = List#linked_list.head,
            NewHead = add_node_at_index_helper(Head, NewNode, Index, CurrentIndex, 0),
            List#linked_list{head = NewHead}
    end.

add_node_at_index_helper(Node, NewNode, Index, CurrentIndex, PrevIndex) ->
    if
        Node =:= none ->
            NewNode;
        CurrentIndex =:= Index ->
            NewNode#node{next = Node};
        true ->
            Node#node{next = add_node_at_index_helper(Node#node.next, NewNode, Index, CurrentIndex + 1, PrevIndex + 1)}
    end.

delete_node_at_index(List, Index, CurrentIndex, PrevNode) ->
    case List#linked_list.head of
        none -> none;
        Head ->
            if
                CurrentIndex =:= Index ->
                    PrevNode#node{next = Head#node.next};
                true ->
                    NewHead = delete_node_at_index_helper(Head, Index, CurrentIndex + 1, PrevNode),
                    List#linked_list{head = NewHead}
            end
    end.

delete_node_at_index_helper(Node, Index, CurrentIndex, PrevNode) ->
    case Node#node.next of
        none -> Node;
        Next ->
            if
                CurrentIndex =:= Index ->
                    PrevNode#node{next = Next};
                true ->
                    Node#node{next = delete_node_at_index_helper(Next, Index, CurrentIndex + 1, Node)}
            end
    end.

get_value(Node, Index, CurrentIndex) ->
    case Node of
        none -> -1;
        _ ->
            if
                CurrentIndex =:= Index ->
                    Node#node.value;
                true ->
                    get_value(Node#node.next, Index, CurrentIndex + 1)
            end
    end.