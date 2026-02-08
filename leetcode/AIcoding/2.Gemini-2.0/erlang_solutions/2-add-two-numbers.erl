-module(add_two_numbers).
-export([add_two_numbers/2]).

-record(list_node, {val, next}).

add_two_numbers(L1, L2) ->
    add_two_numbers_helper(L1, L2, 0).

add_two_numbers_helper(null, null, 0) ->
    null;
add_two_numbers_helper(null, null, Carry) ->
    #list_node{val = Carry, next = null};
add_two_numbers_helper(null, L, Carry) ->
    Val = L#list_node.val + Carry,
    NewCarry = Val div 10,
    NewVal = Val rem 10,
    #list_node{val = NewVal, next = add_two_numbers_helper(null, L#list_node.next, NewCarry)};
add_two_numbers_helper(L, null, Carry) ->
    Val = L#list_node.val + Carry,
    NewCarry = Val div 10,
    NewVal = Val rem 10,
    #list_node{val = NewVal, next = add_two_numbers_helper(null, L#list_node.next, NewCarry)};
add_two_numbers_helper(L1, L2, Carry) ->
    Val = L1#list_node.val + L2#list_node.val + Carry,
    NewCarry = Val div 10,
    NewVal = Val rem 10,
    #list_node{val = NewVal, next = add_two_numbers_helper(L1#list_node.next, L2#list_node.next, NewCarry)}.