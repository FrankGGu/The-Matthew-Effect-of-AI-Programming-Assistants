-module(three_sum_closest).
-export([three_sum_closest/2]).

three_sum_closest(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    three_sum_closest_helper(SortedNums, Target, 0, Len - 1, hd(SortedNums) + hd(tl(SortedNums)) + hd(tl(tl(SortedNums))), infinity).

three_sum_closest_helper(_Nums, _Target, _I, _Len, Closest, Closest) when Closest /= infinity ->
    Closest;
three_sum_closest_helper(Nums, Target, I, Len, _Closest, Best) ->
    if I >= Len - 2 then
        Best
    else
        L = I + 1,
        R = Len,
        three_sum_closest_inner(Nums, Target, I, L, R, Best)
    end.

three_sum_closest_inner(Nums, Target, I, L, R, Best) when L >= R ->
    three_sum_closest_helper(Nums, Target, I + 1, length(Nums) - 1, hd(Nums) + hd(tl(Nums)) + hd(tl(tl(Nums))), Best);
three_sum_closest_inner(Nums, Target, I, L, R, Best) ->
    Sum = lists:nth(I, Nums) + lists:nth(L, Nums) + lists:nth(R, Nums),
    if abs(Sum - Target) < abs(Best - Target) then
        if Sum < Target then
            three_sum_closest_inner(Nums, Target, I, L + 1, R, Sum)
        else if Sum > Target then
            three_sum_closest_inner(Nums, Target, I, L, R - 1, Sum)
        else
            Sum
        end
    else
        if Sum < Target then
            three_sum_closest_inner(Nums, Target, I, L + 1, R, Best)
        else if Sum > Target then
            three_sum_closest_inner(Nums, Target, I, L, R - 1, Best)
        else
            Best
        end
    end.