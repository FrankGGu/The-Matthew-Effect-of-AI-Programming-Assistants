-module(solution).
-export([num_subarray_bounded_max/3]).

num_subarray_bounded_max(A, L, R) ->
    num_subarrays(A, R) - num_subarrays(A, L - 1).

num_subarrays([], _) -> 0;
num_subarrays([H | T], X) ->
    if 
        H > X -> 
            num_subarrays(T, X);
        true -> 
            1 + num_subarrays(T, X)
    end.