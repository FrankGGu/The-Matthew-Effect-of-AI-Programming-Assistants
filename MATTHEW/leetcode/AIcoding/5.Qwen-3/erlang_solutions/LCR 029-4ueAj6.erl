-module(insert_into_circular_sorted_list).
-export([insert/1]).

-include_lib("eunit/include/eunit.hrl").

-type node() :: #node{}.
-record(node, {val, next}).

-spec insert(node()) -> node().
insert(#node{val = Val, next = Next} = Node) ->
    case Next of
        Node ->
            % Only one node in the list
            NewNode = #node{val = Val, next = Node},
            NewNode;
        _ ->
            InsertionPoint = find_insertion_point(Node, Node),
            insert_after(InsertionPoint, Val)
    end.

find_insertion_point(Current, Start) ->
    case Current#node.next of
        Start ->
            Current;
        _ when Current#node.val =< Current#node.next#node.val ->
            if
                Current#node.val =< Val, Val =< Current#node.next#node.val ->
                    Current;
                true ->
                    find_insertion_point(Current#node.next, Start)
            end;
        _ ->
            if
                Current#node.val > Current#node.next#node.val ->
                    if
                        Val >= Current#node.val; Val =< Current#node.next#node.val ->
                            Current;
                        true ->
                            find_insertion_point(Current#node.next, Start)
                    end;
                true ->
                    find_insertion_point(Current#node.next, Start)
            end
    end.

insert_after(#node{next = Next} = Current, Val) ->
    NewNode = #node{val = Val, next = Next},
    Current#node{next = NewNode}.