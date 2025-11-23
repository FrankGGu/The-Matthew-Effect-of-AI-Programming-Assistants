-module(solution).
-export([excellentPairs/2]).

excellentPairs(Nums, K) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    NumsArray = array:from_list(SortedNums),

    count_excellent_pairs(NumsArray, K, N, 0, N - 1, 0).

count_excellent_pairs(NumsArray, K, N, LeftPtr, RightPtr, Acc) ->
    if LeftPtr >= N ->
        Acc;
    true ->
        X = array:get(LeftPtr, NumsArray),

        NewRightPtr = find_lower_bound_for_sum(NumsArray, K - X, RightPtr),

        CountForX = N - 1 - NewRightPtr,

        count_excellent_pairs(NumsArray, K, N, LeftPtr + 1, NewRightPtr, Acc + CountForX)
    end.

find_lower_bound_for_sum(NumsArray, Target, CurrentRightPtr) ->
    find_lower_bound_for_sum_loop(NumsArray, Target, CurrentRightPtr).

find_lower_bound_for_sum_loop(NumsArray, Target, J) ->
    if J < 0 ->
        J;
    true ->
        Val = array:get(J, NumsArray),
        if Val >= Target ->
            find_lower_bound_for_sum_loop(NumsArray, Target, J - 1);
        true ->
            J
        end
    end.