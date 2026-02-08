-module(solution).
-export([max_subarrays/1]).

max_subarrays(A) ->
    N = length(A),
    max_subarrays(A, N, 0, 0).

max_subarrays([], _, Count, _) ->
    Count;
max_subarrays([H | T], N, Count, Prev) when H > Prev ->
    max_subarrays(T, N, Count + 1, H);
max_subarrays([H | T], N, Count, Prev) ->
    max_subarrays(T, N, Count, Prev).