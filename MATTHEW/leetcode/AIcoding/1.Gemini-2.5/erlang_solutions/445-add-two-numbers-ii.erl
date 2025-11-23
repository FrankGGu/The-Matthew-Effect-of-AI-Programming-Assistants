-module(solution).
-export([addTwoNumbers/2]).

addTwoNumbers(L1, L2) ->
    R1 = lists:reverse(L1),
    R2 = lists:reverse(L2),

    SumReversed = add_reversed_lists(R1, R2, 0),

    lists:reverse(SumReversed).

add_reversed_lists([], [], 0) ->
    [];
add_reversed_lists([], [], Carry) when Carry > 0 ->
    [Carry];
add_reversed_lists([H1|T1], [], Carry) ->
    Sum = H1 + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add_reversed_lists(T1, [], NewCarry)];
add_reversed_lists([], [H2|T2], Carry) ->
    Sum = H2 + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add_reversed_lists([], T2, NewCarry)];
add_reversed_lists([H1|T1], [H2|T2], Carry) ->
    Sum = H1 + H2 + Carry,
    Digit = Sum rem 10,
    NewCarry = Sum div 10,
    [Digit | add_reversed_lists(T1, T2, NewCarry)].