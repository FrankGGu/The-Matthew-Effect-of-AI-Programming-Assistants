-module(small_divisor).
-export([smallest_divisor/2]).

smallest_divisor(Nums, Threshold) ->
    Left = 1,
    Right = lists:max(Nums),
    binary_search(Nums, Threshold, Left, Right).

binary_search(Nums, Threshold, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    Sum = sum_division(Nums, Mid),
    if
        Sum =< Threshold -> binary_search(Nums, Threshold, Left, Mid - 1);
        true -> binary_search(Nums, Threshold, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) -> Left.

sum_division([], _) -> 0;
sum_division([H | T], Divisor) ->
    (H + Divisor - 1) div Divisor + sum_division(T, Divisor).