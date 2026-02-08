-module(find_the_power_of_k_size_subarrays_ii).
-export([power_of_subarrays/2]).

power_of_subarrays(Nums, K) ->
  power_of_subarrays(Nums, K, 0, length(Nums) - K + 1, 0, 0).

power_of_subarrays(_, _, End, End, Sum, Count) ->
  Sum * 1.0 / Count;
power_of_subarrays(Nums, K, Start, End, Sum, Count) ->
  Subarray = lists:sublist(Nums, Start + 1, K),
  NewSum = Sum + calculate_power(Subarray),
  power_of_subarrays(Nums, K, Start + 1, End, NewSum, Count + 1).

calculate_power(Subarray) ->
  lists:sum(Subarray).