-module(convert_binary_linked_list_to_integer).
-export([get_decimal_value/1]).

-record(list_node, {val, next}).

get_decimal_value(#list_node{val = Val, next = Next}) ->
    get_decimal_value(Val, Next).

get_decimal_value(Val, null) ->
    Val;
get_decimal_value(Val, Next) ->
    (Val bsl 1) + get_decimal_value(Next).