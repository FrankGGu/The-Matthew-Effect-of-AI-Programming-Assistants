-module(solution).
-export([missingInteger/1]).

missingInteger(Nums) ->
    PrefixSum = calculate_longest_prefix_sum(Nums),
    NumsSet = gb_sets:from_list(Nums),
    find_smallest_missing(PrefixSum, NumsSet).

calculate_longest_prefix_sum([H | T]) ->
    calculate_longest_prefix_sum_acc(T, H, H).

calculate_longest_prefix_sum_acc([], _Prev, CurrentSum) ->
    CurrentSum;
calculate_longest_prefix_sum_acc([H | T], Prev, CurrentSum) ->
    if
        H == Prev + 1 ->
            calculate_longest_prefix_sum_acc(T, H, CurrentSum + H);
        true ->
            CurrentSum
    end.

find_smallest_missing(CurrentVal, NumsSet) ->
    if
        gb_sets:is_member(CurrentVal, NumsSet) ->
            find_smallest_missing(CurrentVal + 1, NumsSet);
        true ->
            CurrentVal
    end.