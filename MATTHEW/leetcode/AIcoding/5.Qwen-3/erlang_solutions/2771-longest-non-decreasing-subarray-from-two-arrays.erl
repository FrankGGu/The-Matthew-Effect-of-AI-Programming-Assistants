-module(longest_non_decreasing_subarray_from_two_arrays).
-export([longest_alternating_subarray/2]).

longest_alternating_subarray(A, B) ->
    Max = 0,
    N = length(A),
    M = length(B),
    I = 0,
    J = 0,
    Current = 0,
    Longest = 0,
    helper(A, B, I, J, Current, Longest, N, M).

helper(_, _, _, _, _, Longest, _, _) ->
    Longest;

helper(A, B, I, J, Current, Longest, N, M) ->
    if
        I < N andalso J < M ->
            if
                A!!I >= B!!J ->
                    helper(A, B, I + 1, J, Current + 1, max(Longest, Current + 1), N, M);
                true ->
                    helper(A, B, I, J + 1, Current + 1, max(Longest, Current + 1), N, M)
            end;
        I < N ->
            helper(A, B, I + 1, J, Current + 1, max(Longest, Current + 1), N, M);
        J < M ->
            helper(A, B, I, J + 1, Current + 1, max(Longest, Current + 1), N, M);
        true ->
            Longest
    end.