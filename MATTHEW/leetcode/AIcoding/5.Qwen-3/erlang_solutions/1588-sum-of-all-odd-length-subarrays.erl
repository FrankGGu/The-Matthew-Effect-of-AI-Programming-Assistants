-module(solution).
-export([sum_odd_length_subarrays/1]).

sum_odd_length_subarrays(Nums) ->
    sum_odd_length_subarrays(Nums, 0, 0).

sum_odd_length_subarrays([], _, Sum) ->
    Sum;
sum_odd_length_subarrays([H|T], Index, Sum) ->
    Length = length([H|T]),
    Count = ((Length + 1) div 2) * ((Length + 1) div 2),
    NewSum = Sum + H * Count,
    sum_odd_length_subarrays(T, Index + 1, NewSum).