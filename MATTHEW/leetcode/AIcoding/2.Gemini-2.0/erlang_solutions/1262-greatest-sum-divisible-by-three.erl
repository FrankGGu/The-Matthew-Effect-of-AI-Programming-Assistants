-module(greatest_sum_divisible_by_three).
-export([max_sum_divisible_by_three/1]).

max_sum_divisible_by_three(Nums) ->
    max_sum_divisible_by_three(Nums, 0, 0, 0).

max_sum_divisible_by_three([], Sum0, Sum1, Sum2) ->
    case Sum0 of
        _ when Sum1 > 0, Sum2 > 0 ->
            max(Sum0, max(Sum0-Sum1, Sum0-Sum2));
        _ when Sum1 > 0 ->
            max(Sum0, Sum0-Sum1);
        _ when Sum2 > 0 ->
            max(Sum0, Sum0-Sum2);
        _ ->
            Sum0
    end;
max_sum_divisible_by_three([H|T], Sum0, Sum1, Sum2) ->
    case H rem 3 of
        0 ->
            max_sum_divisible_by_three(T, Sum0+H, Sum1, Sum2);
        1 ->
            max_sum_divisible_by_three(T, Sum0, min(Sum1+H,Sum0), min(Sum2+H,Sum1));
        2 ->
            max_sum_divisible_by_three(T, Sum0, min(Sum1+H,Sum2), min(Sum2+H,Sum0))
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.

min(A,B) ->
    if A > B -> B;
    true -> A
    end.