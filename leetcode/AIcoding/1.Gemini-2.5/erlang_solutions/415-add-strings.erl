-module(solution).
-export([addStrings/2]).

addStrings(Num1, Num2) ->
    add_strings_rec(lists:reverse(Num1), lists:reverse(Num2), 0, []).

add_strings_rec([], [], 0, Acc) ->
    lists:reverse(Acc);
add_strings_rec([], [], Carry, Acc) when Carry > 0 ->
    lists:reverse([Carry + $0 | Acc]);
add_strings_rec(S1, S2, Carry, Acc) ->
    {D1, Rest1} = get_digit_and_rest(S1),
    {D2, Rest2} = get_digit_and_rest(S2),

    Sum = D1 + D2 + Carry,
    NewDigit = (Sum rem 10) + $0,
    NewCarry = Sum div 10,

    add_strings_rec(Rest1, Rest2, NewCarry, [NewDigit | Acc]).

get_digit_and_rest([H|T]) -> {H - $0, T};
get_digit_and_rest([]) -> {0, []}.