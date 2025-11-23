-module(solution).
-export([max_size/2]).

max_size(N, A) ->
    K = length(A) div 3,
    Max = max_size_helper(A, K, 0, 0, 0, 0).

max_size_helper(A, K, I, Count, Sum1, Sum2) when K > 0, I < length(A) ->
    Max1 = max_size_helper(A, K, I + 1, Count, Sum1, Sum2),
    Max2 = max_size_helper(A, K - 1, I + 1, Count + 1, Sum1 + lists:nth(I + 1, A), Sum2),
    max(Max1, Max2);
max_size_helper(_, _, _, Count, Sum1, _) when Count == 0 -> Sum1;
max_size_helper(_, _, _, Count, _, Sum2) when Count > 0 -> Sum2.