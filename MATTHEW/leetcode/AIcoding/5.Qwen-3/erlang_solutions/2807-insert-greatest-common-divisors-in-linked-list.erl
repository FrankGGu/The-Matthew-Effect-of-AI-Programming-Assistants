-module(solution).
-export([insert_gcd_in_linked_list/1]).

-record(list_node, {val, next}).

insert_gcd_in_linked_list(Head) ->
    insert_gcd_in_linked_list(Head, nil).

insert_gcd_in_linked_list(nil, _) ->
    nil;
insert_gcd_in_linked_list(#list_node{val = V, next = Next}, Prev) ->
    case Prev of
        nil ->
            NewNode = #list_node{val = V, next = insert_gcd_in_linked_list(Next, #list_node{val = V, next = nil})},
            NewNode;
        _ ->
            Gcd = gcd(Prev#list_node.val, V),
            NewNode = #list_node{val = Gcd, next = #list_node{val = V, next = insert_gcd_in_linked_list(Next, #list_node{val = V, next = nil})}},
            NewNode
    end.

gcd(A, B) when A < B ->
    gcd(B, A);
gcd(A, 0) ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).