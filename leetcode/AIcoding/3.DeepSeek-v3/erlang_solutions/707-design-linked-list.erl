-module(linked_list).
-export([init/0, get/2, add_at_head/2, add_at_tail/2, add_at_index/3, delete_at_index/2]).

-record(node, {val, next}).

init() ->
    #node{val = undefined, next = undefined}.

get(Head, Index) ->
    get_helper(Head, Index, 0).

get_helper(#node{val = Val, next = _Next}, Index, Index) ->
    Val;
get_helper(#node{next = Next}, Index, Pos) when Next =/= undefined ->
    get_helper(Next, Index, Pos + 1);
get_helper(_, _, _) ->
    -1.

add_at_head(Head, Val) ->
    #node{val = Val, next = Head}.

add_at_tail(Head, Val) ->
    add_at_tail_helper(Head, Val).

add_at_tail_helper(#node{next = undefined} = Node, Val) ->
    Node#node{next = #node{val = Val, next = undefined}};
add_at_tail_helper(#node{next = Next} = Node, Val) ->
    Node#node{next = add_at_tail_helper(Next, Val)};
add_at_tail_helper(undefined, Val) ->
    #node{val = Val, next = undefined}.

add_at_index(Head, Index, Val) ->
    add_at_index_helper(Head, Index, Val, 0).

add_at_index_helper(#node{next = Next} = Node, 0, Val, _Pos) ->
    #node{val = Val, next = Node};
add_at_index_helper(#node{val = V, next = Next} = Node, Index, Val, Pos) when Pos + 1 =:= Index ->
    Node#node{next = #node{val = Val, next = Next}};
add_at_index_helper(#node{next = Next} = Node, Index, Val, Pos) when Next =/= undefined ->
    Node#node{next = add_at_index_helper(Next, Index, Val, Pos + 1)};
add_at_index_helper(undefined, 0, Val, _Pos) ->
    #node{val = Val, next = undefined};
add_at_index_helper(_, _, _, _) ->
    undefined.

delete_at_index(Head, Index) ->
    delete_at_index_helper(Head, Index, 0).

delete_at_index_helper(#node{next = Next}, 0, _Pos) ->
    Next;
delete_at_index_helper(#node{val = V, next = Next} = Node, Index, Pos) when Pos + 1 =:= Index ->
    case Next of
        #node{next = NextNext} ->
            Node#node{next = NextNext};
        undefined ->
            Node#node{next = undefined}
    end;
delete_at_index_helper(#node{next = Next} = Node, Index, Pos) when Next =/= undefined ->
    Node#node{next = delete_at_index_helper(Next, Index, Pos + 1)};
delete_at_index_helper(_, _, _) ->
    undefined.