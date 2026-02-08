-module(linked_list).
-export([constructor/0, append/2, count/1, get/2, get_at/2, delete_at/2, add_at/3, add_before/3, add_after/3, reverse/1]).

-record(node, {val, next}).

constructor() ->
    nil.

append(List, Val) ->
    case List of
        nil -> #node{val = Val, next = nil};
        _ ->
            Current = List,
            while_current(Current),
            NewNode = #node{val = Val, next = nil},
            set_next(Current, NewNode)
    end.

while_current(Current) ->
    case Current#node.next of
        nil -> ok;
        Next -> while_current(Next)
    end.

set_next(Node, NewNode) ->
    Node#node.next = NewNode.

count(List) ->
    count(List, 0).

count(nil, Acc) ->
    Acc;
count(#node{next = Next}, Acc) ->
    count(Next, Acc + 1).

get(List, Index) ->
    get(List, Index, 0).

get(nil, _, _) ->
    -1;
get(#node{val = Val, next = Next}, Index, CurrentIndex) when CurrentIndex == Index ->
    Val;
get(#node{next = Next}, Index, CurrentIndex) ->
    get(Next, Index, CurrentIndex + 1).

get_at(List, Index) ->
    get(List, Index, 0).

delete_at(List, Index) ->
    delete_at(List, Index, 0, nil).

delete_at(nil, _, _, _) ->
    nil;
delete_at(#node{next = Next}, Index, CurrentIndex, Prev) when CurrentIndex == Index ->
    if
        Prev == nil -> Next;
        true -> Prev#node.next = Next
    end;
delete_at(#node{next = Next}, Index, CurrentIndex, Prev) ->
    delete_at(Next, Index, CurrentIndex + 1, List).

add_at(List, Index, Val) ->
    add_at(List, Index, Val, 0, nil).

add_at(nil, Index, Val, CurrentIndex, Prev) when CurrentIndex == Index ->
    #node{val = Val, next = nil};
add_at(nil, _, _, _, _) ->
    List;
add_at(#node{next = Next}, Index, Val, CurrentIndex, Prev) when CurrentIndex == Index ->
    NewNode = #node{val = Val, next = List},
    if
        Prev == nil -> NewNode;
        true -> Prev#node.next = NewNode
    end;
add_at(#node{next = Next}, Index, Val, CurrentIndex, Prev) ->
    add_at(Next, Index, Val, CurrentIndex + 1, List).

add_before(List, TargetVal, Val) ->
    add_before(List, TargetVal, Val, nil).

add_before(nil, _, _, _) ->
    List;
add_before(#node{val = Val, next = Next}, TargetVal, NewVal, Prev) when Val == TargetVal ->
    NewNode = #node{val = NewVal, next = List},
    if
        Prev == nil -> NewNode;
        true -> Prev#node.next = NewNode
    end;
add_before(#node{next = Next}, TargetVal, NewVal, Prev) ->
    add_before(Next, TargetVal, NewVal, List).

add_after(List, TargetVal, Val) ->
    add_after(List, TargetVal, Val, nil).

add_after(nil, _, _, _) ->
    List;
add_after(#node{val = Val, next = Next}, TargetVal, NewVal, Prev) when Val == TargetVal ->
    NewNode = #node{val = NewVal, next = Next},
    Prev#node.next = NewNode;
add_after(#node{next = Next}, TargetVal, NewVal, Prev) ->
    add_after(Next, TargetVal, NewVal, List).

reverse(List) ->
    reverse(List, nil).

reverse(nil, Acc) ->
    Acc;
reverse(#node{val = Val, next = Next}, Acc) ->
    reverse(Next, #node{val = Val, next = Acc}).