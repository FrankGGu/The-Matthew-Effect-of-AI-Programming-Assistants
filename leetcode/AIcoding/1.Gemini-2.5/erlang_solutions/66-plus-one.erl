-module(solution).
-export([plus_one/1]).

plus_one(Digits) ->
    ReversedDigits = lists:reverse(Digits),
    ResultReversed = add_one_to_reversed(ReversedDigits, 1),
    lists:reverse(ResultReversed).

add_one_to_reversed([], 0) ->
    [];
add_one_to_reversed([], Carry) when Carry > 0 ->
    [Carry];
add_one_to_reversed([H|T], Carry) ->
    Sum = H + Carry,
    NewDigit = Sum rem 10,
    NewCarry = Sum div 10,
    [NewDigit | add_one_to_reversed(T, NewCarry)].