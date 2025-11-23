-module(solution).
-export([num_subarrays/2]).

num_subarrays(A, K) ->
    N = length(A),
    num_subarrays_helper(A, K, N, 0, 0, 0).

num_subarrays_helper([], _, _, Count, _, _) -> Count;
num_subarrays_helper([H | T], K, N, Count, C, And) ->
    NewAnd = And band H,
    case NewAnd of
        K -> num_subarrays_helper(T, K, N, Count + C + 1, C + 1, NewAnd);
        _ -> num_subarrays_helper(T, K, N, Count, 0, NewAnd)
    end.