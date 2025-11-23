-module(solution).
-export([splitArray/2]).

splitArray(Nums, K) ->
    MinPossibleSum = lists:max(Nums),
    MaxPossibleSum = lists:sum(Nums),
    binary_search(Nums, K, MinPossibleSum, MaxPossibleSum, MaxPossibleSum).

binary_search(Nums, K, Low, High, Ans) ->
    if
        Low > High ->
            Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            case is_possible(Nums, K, Mid) of
                true ->
                    binary_search(Nums, K, Low, Mid - 1, Mid);
                false ->
                    binary_search(Nums, K, Mid + 1, High, Ans)
            end
    end.

is_possible(Nums, K, MaxSum) ->
    is_possible_impl(Nums, K, MaxSum, 0, 1).

is_possible_impl(Nums, K, MaxSum, CurrentSum, NumSubarrays) ->
    if
        NumSubarrays > K ->
            false;
        true ->
            case Nums of
                [] ->
                    NumSubarrays =< K;
                [H|T] ->
                    if
                        CurrentSum + H =< MaxSum ->
                            is_possible_impl(T, K, MaxSum, CurrentSum + H, NumSubarrays);
                        true ->
                            is_possible_impl(T, K, MaxSum, H, NumSubarrays + 1)
                    end
            end
    end.