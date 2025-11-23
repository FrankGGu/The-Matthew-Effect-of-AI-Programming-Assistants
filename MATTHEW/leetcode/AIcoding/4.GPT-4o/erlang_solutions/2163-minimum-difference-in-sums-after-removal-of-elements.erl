-module(solution).
-export([minimumDifference/1]).

minimumDifference(Numbers) ->
    N = length(Numbers) div 2,
    TotalSum = lists:sum(Numbers),
    SubsetSums = calculate_subset_sums(Numbers, N),
    MinimumDiff = lists:min([abs(TotalSum - 2 * SubsetSum) || SubsetSum <- SubsetSums]),
    MinimumDiff.

calculate_subset_sums(Numbers, N) ->
    calculate_subset_sums_helper(Numbers, N, []).

calculate_subset_sums_helper(_, 0, Acc) ->
    [lists:sum(Acc)];
calculate_subset_sums_helper([], _, _) ->
    [];
calculate_subset_sums_helper([H | T], N, Acc) ->
    calculate_subset_sums_helper(T, N, Acc) ++
    calculate_subset_sums_helper(T, N - 1, [H | Acc]).