-module(solution).
-export([max_sum_after_removal/1]).

max_sum_after_removal(List) ->
    N = length(List),
    MaxSum = lists:sum(List),
    MaxSumAfterRemoval(N, List, MaxSum, 0).

MaxSumAfterRemoval(_, [], MaxSum, BestSum) ->
    max(MaxSum, BestSum);
MaxSumAfterRemoval(N, [H | T], MaxSum, BestSum) ->
    NewBestSum = max(BestSum, MaxSum - H),
    MaxSumAfterRemoval(N - 1, T, MaxSum - H, NewBestSum).