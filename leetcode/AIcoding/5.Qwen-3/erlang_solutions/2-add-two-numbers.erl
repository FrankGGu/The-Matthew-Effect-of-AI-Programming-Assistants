-module(add_two_numbers).
-export([add_two_numbers/2]).

-record(list_node, {val, next}).

-type list_node() :: #list_node{}.

-spec add_two_numbers(list_node(), list_node()) -> list_node().
add_two_numbers(Num1, Num2) ->
    add_two_numbers(Num1, Num2, 0).

add_two_numbers(#list_node{val = V1, next = N1}, #list_node{val = V2, next = N2}, Carry) ->
    Sum = V1 + V2 + Carry,
    Val = Sum rem 10,
    NewCarry = Sum div 10,
    #list_node{
        val = Val,
        next = add_two_numbers(N1, N2, NewCarry)
    };
add_two_numbers(_, _, 0) ->
    null;
add_two_numbers(_, _, Carry) ->
    #list_node{
        val = Carry,
        next = null
    }.