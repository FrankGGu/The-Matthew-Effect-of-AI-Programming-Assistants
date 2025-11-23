-module(add_strings).
-export([add_strings/2]).

add_strings(Num1, Num2) ->
    add(reverse(Num1), reverse(Num2), 0, []).

reverse(Str) ->
    lists:reverse(Str).

add([], [], Carry, Result) ->
    case Carry of
        0 -> lists:reverse(Result);
        _ -> lists:reverse([Carry + $0 | Result])
    end;

add([H1 | T1], [], Carry, Result) ->
    Digit = H1 - $0,
    Sum = Digit + Carry,
    add(T1, [], Sum div 10, [Sum rem 10 + $0 | Result]);

add([], [H2 | T2], Carry, Result) ->
    Digit = H2 - $0,
    Sum = Digit + Carry,
    add([], T2, Sum div 10, [Sum rem 10 + $0 | Result]);

add([H1 | T1], [H2 | T2], Carry, Result) ->
    Digit1 = H1 - $0,
    Digit2 = H2 - $0,
    Sum = Digit1 + Digit2 + Carry,
    add(T1, T2, Sum div 10, [Sum rem 10 + $0 | Result]).