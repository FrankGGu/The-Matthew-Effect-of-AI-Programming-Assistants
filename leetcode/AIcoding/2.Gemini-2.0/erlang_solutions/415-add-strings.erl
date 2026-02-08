-module(add_strings).
-export([add_strings/2]).

add_strings(Num1, Num2) ->
    add_strings(string_to_list(Num1), string_to_list(Num2), 0, []).

add_strings([], [], Carry, Acc) ->
    case Carry of
        0 -> list_to_string(lists:reverse(Acc));
        _ -> list_to_string(lists:reverse([integer_to_list(Carry) ++ Acc]))
    end;
add_strings([], Num2, Carry, Acc) ->
    add_strings(["0"], Num2, Carry, Acc);
add_strings(Num1, [], Carry, Acc) ->
    add_strings(Num1, ["0"], Carry, Acc);
add_strings([H1|T1], [H2|T2], Carry, Acc) ->
    N1 = list_to_integer([H1]),
    N2 = list_to_integer([H2]),
    Sum = N1 + N2 + Carry,
    NewCarry = Sum div 10,
    Digit = Sum rem 10,
    add_strings(T1, T2, NewCarry, [integer_to_list(Digit) ++ Acc]).

string_to_list(String) ->
    lists:reverse(string:characters(String, all)).