-module(all_one_data_structure).
-export([new/0, inc/2, dec/2, get_max_key/1, get_min_key/1]).

-record(node, {key, count, next, prev}).
-record(list, {head, tail, size}).

new() ->
    #list{head = nil, tail = nil, size = 0}.

inc(List, Key) ->
    case get_count(List, Key) of
        undefined ->
            insert_new(List, Key);
        Count ->
            insert_after(List, Key, Count)
    end.

dec(List, Key) ->
    case get_count(List, Key) of
        undefined ->
            List;
        1 ->
            remove_key(List, Key);
        Count ->
            insert_before(List, Key, Count)
    end.

get_max_key(List) ->
    case List#list.head of
        nil -> "";
        Head ->
            get_key(Head)
    end.

get_min_key(List) ->
    case List#list.tail of
        nil -> "";
        Tail ->
            get_key(Tail)
    end.

get_count(List, Key) ->
    get_count(List#list.head, Key).

get_count(nil, _) ->
    undefined;
get_count(Node, Key) when Node#node.key == Key ->
    Node#node.count;
get_count(Node, Key) ->
    get_count(Node#node.next, Key).

insert_new(List, Key) ->
    insert_before(List, Key, 0).

insert_before(List, Key, Count) ->
    NewCount = Count + 1,
    NewNode = #node{key = Key, count = NewCount, next = nil, prev = nil},
    case List#list.head of
        nil ->
            NewList = List#list{head = NewNode, tail = NewNode, size = 1},
            NewList;
        Head ->
            case Head#node.count of
                NewCount ->
                    insert_after_head(List, NewNode);
                _ ->
                    insert_before_node(List, Head, NewNode)
            end
    end.

insert_after(List, Key, Count) ->
    NewCount = Count + 1,
    NewNode = #node{key = Key, count = NewCount, next = nil, prev = nil},
    case List#list.head of
        nil ->
            List;
        Head ->
            case Head#node.count of
                NewCount ->
                    insert_after_tail(List, NewNode);
                _ ->
                    insert_after_node(List, Head, NewNode)
            end
    end.

insert_after_head(List, NewNode) ->
    NewNode#node{next = List#list.head},
    List#list{head = NewNode, size = List#list.size + 1}.

insert_after_tail(List, NewNode) ->
    List#list{tail = NewNode, size = List#list.size + 1}.

insert_before_node(List, Node, NewNode) ->
    Prev = Node#node.prev,
    if
        Prev == nil ->
            NewNode#node{next = Node},
            Node#node{prev = NewNode},
            List#list{head = NewNode, size = List#list.size + 1};
        true ->
            Prev#node{next = NewNode},
            NewNode#node{prev = Prev, next = Node},
            Node#node{prev = NewNode},
            List#list{size = List#list.size + 1}
    end.

insert_after_node(List, Node, NewNode) ->
    Next = Node#node.next,
    if
        Next == nil ->
            NewNode#node{prev = Node},
            Node#node{next = NewNode},
            List#list{tail = NewNode, size = List#list.size + 1};
        true ->
            Next#node{prev = NewNode},
            NewNode#node{prev = Node, next = Next},
            Node#node{next = NewNode},
            List#list{size = List#list.size + 1}
    end.

remove_key(List, Key) ->
    case get_node(List, Key) of
        nil ->
            List;
        Node ->
            Prev = Node#node.prev,
            Next = Node#node.next,
            if
                Prev == nil andalso Next == nil ->
                    List#list{head = nil, tail = nil, size = 0};
                Prev == nil ->
                    Next#node{prev = nil},
                    List#list{head = Next, size = List#list.size - 1};
                Next == nil ->
                    Prev#node{next = nil},
                    List#list{tail = Prev, size = List#list.size - 1};
                true ->
                    Prev#node{next = Next},
                    Next#node{prev = Prev},
                    List#list{size = List#list.size - 1}
            end
    end.

get_node(List, Key) ->
    get_node(List#list.head, Key).

get_node(nil, _) ->
    nil;
get_node(Node, Key) when Node#node.key == Key ->
    Node;
get_node(Node, Key) ->
    get_node(Node#node.next, Key).

get_key(Node) ->
    Node#node.key.