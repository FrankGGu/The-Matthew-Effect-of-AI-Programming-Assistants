-module(solution).
-export([add_negabinary/2]).

add_negabinary(A, B) ->
    add_negabinary(A, B, 0, []).

add_negabinary([], [], Carry, Result) ->
    case Carry of
        0 -> lists:reverse(Result);
        _ -> add_negabinary([], [], Carry, Result)
    end;
add_negabinary([], [B | Bs], Carry, Result) ->
    add_negabinary([], Bs, Carry, [B + Carry | Result]);
add_negabinary([A | As], [], Carry, Result) ->
    add_negabinary(As, [], Carry, [A + Carry | Result]);
add_negabinary([A | As], [B | Bs], Carry, Result) ->
    Sum = A + B + Carry,
    Digit = Sum rem 2,
    NewCarry = - (Sum div 2),
    add_negabinary(As, Bs, NewCarry, [Digit | Result]).