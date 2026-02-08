-module(maximum_sum_obtained_of_any_permutation).
-export([maxSum/1]).

maxSum(Nums) ->
    lists:sort(Nums, fun(A, B) -> A < B end),
    maxSum(Nums, 0, 0).

maxSum([], _, Sum) ->
    Sum;
maxSum([H | T], Index, Sum) ->
    NewSum = Sum + H * Index,
    maxSum(T, Index + 1, NewSum).