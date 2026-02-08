-module(solution).
-export([divide_array/2]).

divide_array(Nums, K) ->
    N = length(Nums),
    prefix_sums(Nums, K, N).

prefix_sums(Nums, K, N) ->
    lists:foldl(fun(I, Acc) ->
                       calculate_cost(Nums, K, I, Acc)
                   end, lists:duplicate(N + 1, infinity), lists:seq(0, N)).

calculate_cost(_Nums, _K, 0, Acc) ->
    lists:nth(1, Acc);
calculate_cost(Nums, K, I, Acc) ->
    Cost1 = lists:nth(I + 1, Acc),
    Cost2 = calculate_subarray_cost(Nums, K, I) + lists:nth(I - K + 1 + 1, Acc),
    lists:nth(I + 1, lists:nth(I + 1, Acc) orelse Cost2, Acc).

calculate_subarray_cost(Nums, K, I) ->
    SubArray = lists:sublist(Nums, I - K + 1, K),
    Sum = lists:sum(SubArray),
    Sum.

infinity() ->
    math:pow(10, 18).