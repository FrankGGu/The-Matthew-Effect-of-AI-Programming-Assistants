-module(solution).
-export([min_moves/2]).

min_moves(Nums, K) ->
    OnesIndices = find_ones_indices(Nums),
    M = length(OnesIndices),

    B_list = lists:map(fun(Idx, J) -> Idx - J end, OnesIndices, lists:seq(0, M - 1)),
    B = array:from_list(B_list),

    PrefixSumB_list = calculate_prefix_sums(B_list),
    PrefixSumB = array:from_list(PrefixSumB_list),

    calculate_min_cost(B, PrefixSumB, M, K, 0, infinity).

find_ones_indices(Nums) ->
    find_ones_indices(Nums, 0, []).

find_ones_indices([], _, Acc) ->
    lists:reverse(Acc);
find_ones_indices([H|T], Idx, Acc) ->
    case H of
        1 -> find_ones_indices(T, Idx + 1, [Idx | Acc]);
        0 -> find_ones_indices(T, Idx + 1, Acc)
    end.

calculate_prefix_sums(List) ->
    calculate_prefix_sums(List, 0, []).

calculate_prefix_sums([], _, Acc) ->
    lists:reverse(Acc);
calculate_prefix_sums([H|T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    calculate_prefix_sums(T, NewSum, [NewSum | Acc]).

get_prefix_sum(PrefixSumArray, Index) ->
    if Index < 0 ->
        0;
    else
        array:get(Index, PrefixSumArray)
    end.

calculate_min_cost(B, PrefixSumB, M, K, I, CurrentMinCost) ->
    if I > M - K ->
        CurrentMinCost;
    else
        MedianIdxInB = I + (K div 2),
        MedianVal = array:get(MedianIdxInB, B),

        LeftSum = get_prefix_sum(PrefixSumB, I + (K div 2) - 1) - get_prefix_sum(PrefixSumB, I - 1),

        RightSum = get_prefix_sum(PrefixSumB, I + K - 1) - get_prefix_sum(PrefixSumB, I + (K div 2)),

        NumLeft = K div 2,
        NumRight = K - 1 - (K div 2),

        Cost = (NumLeft * MedianVal - LeftSum) + (RightSum - NumRight * MedianVal),

        NewMinCost = min(CurrentMinCost, Cost),
        calculate_min_cost(B, PrefixSumB, M, K, I + 1, NewMinCost)
    end.