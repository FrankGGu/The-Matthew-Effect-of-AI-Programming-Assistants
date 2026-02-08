-module(min_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    ones(Nums) + non_ones(Nums).

ones(Nums) ->
    lists:foldl(fun(X, Acc) -> if X == 1 -> Acc + 1; true -> Acc end end, 0, Nums).

non_ones(Nums) ->
    Len = length(Nums),
    Ones = ones(Nums),
    if Ones > 0 ->
        Len - Ones
    else
        Shortest = shortest_subarray_gcd_one(Nums),
        if Shortest == infinity ->
            -1
        else
            Shortest + Len - 1
        end
    end.

shortest_subarray_gcd_one(Nums) ->
    Len = length(Nums),
    shortest_subarray_gcd_one_helper(Nums, 0, Len, infinity).

shortest_subarray_gcd_one_helper(Nums, Start, Len, MinLen) ->
    if Start >= Len then
        MinLen
    else
        MinLen1 = shortest_subarray_gcd_one_from(Nums, Start, Len, infinity, Nums[Start + 1]),
        shortest_subarray_gcd_one_helper(Nums, Start + 1, Len, min(MinLen, MinLen1))
    end.

shortest_subarray_gcd_one_from(Nums, Start, Len, MinLen, CurrentGCD) ->
    if Start >= Len then
        MinLen
    else
        if CurrentGCD == 1 then
            min(MinLen, Start - Start + 1)
        else
            NextIndex = Start + 1,
            NewGCD = gcd(CurrentGCD, Nums[NextIndex + 1]),
            NewMinLen = shortest_subarray_gcd_one_from(Nums, NextIndex, Len, MinLen, NewGCD),
            min(MinLen, NewMinLen + 1)
        end
    end.

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).