-module(solution).
-export([num_zero_filled_subarrays/1]).

num_zero_filled_subarrays(B) ->
    num_zero_filled_subarrays(B, 0, 0).

num_zero_filled_subarrays([], _, Acc) ->
    Acc;
num_zero_filled_subarrays([0 | T], Count, Acc) ->
    num_zero_filled_subarrays(T, Count + 1, Acc + Count + 1);
num_zero_filled_subarrays([_ | T], _, Acc) ->
    num_zero_filled_subarrays(T, 0, Acc).