-module(solution).
-export([longest_ideal_subsequence/3]).

longest_ideal_subsequence(N, K, A) ->
    longest_ideal_subsequence_helper(N, K, A, 0, 0).

longest_ideal_subsequence_helper(N, K, A, Index, CurrentLength) when Index >= N ->
    CurrentLength;
longest_ideal_subsequence_helper(N, K, A, Index, CurrentLength) ->
    NewLength = case (A[Index] >= 0, A[Index] =< K) of
        true -> CurrentLength + 1;
        false -> CurrentLength
    end,
    longest_ideal_subsequence_helper(N, K, A, Index + 1, NewLength).