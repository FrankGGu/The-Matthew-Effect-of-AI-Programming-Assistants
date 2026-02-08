-module(solution).
-export([add_negabinary/2]).

add_negabinary(A, B) ->
    add_negabinary_helper(A, B, 0, []).

add_negabinary_helper([], [], 0, Acc) ->
    lists:reverse(Acc);
add_negabinary_helper([], [], Carry, Acc) when Carry =< 0 ->
    lists:reverse(Acc);
add_negabinary_helper([], [], Carry, Acc) ->
    add_negabinary_helper([], [1], Carry, Acc);
add_negabinary_helper(A, [], Carry, Acc) ->
    add_negabinary_helper(A, [0], Carry, Acc);
add_negabinary_helper([], B, Carry, Acc) ->
    add_negabinary_helper([0], B, Carry, Acc);
add_negabinary_helper([HA | TA], [HB | TB], Carry, Acc) ->
    Sum = HA + HB + Carry,
    NewCarry = case Sum of
        0 -> 0;
        1 -> 0;
        2 -> 1;
        _ -> -1
    end,
    NewDigit = case Sum rem 2 of
        0 -> 0;
        _ -> 1
    end,
    add_negabinary_helper(TA, TB, NewCarry, [NewDigit | Acc]).