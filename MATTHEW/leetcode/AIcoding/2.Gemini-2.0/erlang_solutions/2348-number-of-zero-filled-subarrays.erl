-module(solution).
-export([number_of_zero_filled_subarrays/1]).

number_of_zero_filled_subarrays(Nums) ->
    number_of_zero_filled_subarrays(Nums, 0, 0).

number_of_zero_filled_subarrays([], Acc, Count) ->
    Acc + (Count * (Count + 1)) div 2;
number_of_zero_filled_subarrays([0 | Rest], Acc, Count) ->
    number_of_zero_filled_subarrays(Rest, Acc, Count + 1);
number_of_zero_filled_subarrays([_ | Rest], Acc, Count) ->
    number_of_zero_filled_subarrays(Rest, Acc + (Count * (Count + 1)) div 2, 0).