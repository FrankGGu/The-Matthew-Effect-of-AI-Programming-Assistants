-module(leetcode_67).
-export([add_binary/2]).

add_binary(A, B) ->
    add_binary(list_to_integer(A, 2), list_to_integer(B, 2), []).

add_binary(0, 0, Acc) ->
    lists:reverse(Acc);
add_binary(A, B, Acc) ->
    Sum = A + B,
    Bit = Sum rem 2,
    Carry = Sum div 2,
    add_binary(Carry, 0, [Bit | Acc]).

list_to_integer([], _) ->
    0;
list_to_integer([H | T], Base) ->
    Digit = H - $0,
    Digit * trunc(math:pow(Base, length(T))) + list_to_integer(T, Base).