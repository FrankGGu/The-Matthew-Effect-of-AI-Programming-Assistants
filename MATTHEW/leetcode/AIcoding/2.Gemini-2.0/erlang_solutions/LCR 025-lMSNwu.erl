-module(add_two_numbers_ii).
-export([add_two_numbers/2]).

-spec add_two_numbers([integer()], [integer()]) -> [integer()].
add_two_numbers(L1, L2) ->
    {RevL1, Len1} = reverse(L1, 0, []),
    {RevL2, Len2} = reverse(L2, 0, []),
    {Result, _} = add(RevL1, RevL2, 0, []),
    trim_leading_zeros(lists:reverse(Result)).

reverse([], AccLen, Acc) ->
    {Acc, AccLen};
reverse([H|T], AccLen, Acc) ->
    reverse(T, AccLen + 1, [H|Acc]).

add([], [], Carry, Acc) ->
    case Carry of
        0 -> {Acc, 0};
        _ -> {[Carry] | Acc, 0}
    end;
add([], [H|T], Carry, Acc) ->
    Sum = H + Carry,
    NewCarry = Sum div 10,
    Digit = Sum rem 10,
    add([], T, NewCarry, [Digit|Acc]);
add([H|T], [], Carry, Acc) ->
    Sum = H + Carry,
    NewCarry = Sum div 10,
    Digit = Sum rem 10,
    add(T, [], NewCarry, [Digit|Acc]);
add([H1|T1], [H2|T2], Carry, Acc) ->
    Sum = H1 + H2 + Carry,
    NewCarry = Sum div 10,
    Digit = Sum rem 10,
    add(T1, T2, NewCarry, [Digit|Acc]).

trim_leading_zeros([0]) -> [0];
trim_leading_zeros([0|T]) -> trim_leading_zeros(T);
trim_leading_zeros(L) -> L.