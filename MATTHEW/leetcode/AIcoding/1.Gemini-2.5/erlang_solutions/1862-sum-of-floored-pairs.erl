-module(solution).
-export([sum_of_floored_pairs/1]).

prefix_sum_array(MaxNum, Counts, Acc, I) when I =< MaxNum ->
    Val = array:get(I-1, Acc) + array:get(I, Counts),
    NewAcc = array:set(I, Val, Acc),
    prefix_sum_array(MaxNum, Counts, NewAcc, I+1);
prefix_sum_array(_, _, Acc, _) ->
    Acc.

calculate_y_sum(MaxNum, PrefixCounts, Y, K, AccKSum) when K * Y =< MaxNum ->
    LowerBound = K * Y,
    UpperBound = min((K + 1) * Y - 1, MaxNum),
    CountInRange = array:get(UpperBound, PrefixCounts) - array:get(LowerBound - 1, PrefixCounts),
    NewAccKSum = AccKSum + K * CountInRange,
    calculate_y_sum(MaxNum, PrefixCounts, Y, K+1, NewAccKSum);
calculate_y_sum(_, _, _, _, AccKSum) ->
    AccKSum.

calculate_total_sum(MaxNum, Counts, PrefixCounts, Y, AccTotalSum) when Y =< MaxNum ->
    CountY = array:get(Y, Counts),
    NewAccTotalSum =
        if CountY > 0 ->
            CurrentYSum = calculate_y_sum(MaxNum, PrefixCounts, Y, 1, 0),
            AccTotalSum + CountY * CurrentYSum;
        true ->
            AccTotalSum
        end,
    calculate_total_sum(MaxNum, Counts, PrefixCounts, Y+1, NewAccTotalSum);
calculate_total_sum(_, _, _, _, AccTotalSum) ->
    AccTotalSum.

sum_of_floored_pairs(Nums) ->
    MaxNum = lists:max(Nums),

    Counts0 = array:new([{size, MaxNum + 1}, {fixed, true}, {default, 0}]),
    Counts = lists:foldl(fun(N, Acc) -> array:set(N, array:get(N, Acc) + 1, Acc) end, Counts0, Nums),

    PrefixCounts0 = array:new([{size, MaxNum + 1}, {fixed, true}, {default, 0}]),
    PrefixCounts = prefix_sum_array(MaxNum, Counts, PrefixCounts0, 1),

    calculate_total_sum(MaxNum, Counts, PrefixCounts, 1, 0).