-module(solution).
-export([get_decimal_value/1]).

-record(node, {val, next}).

get_decimal_value(Head) ->
    get_decimal_value(Head, 0).

get_decimal_value(null, Acc) ->
    Acc;
get_decimal_value(#node{val=Val, next=Next}, Acc) ->
    NewAcc = (Acc bsl 1) + Val,
    get_decimal_value(Next, NewAcc).