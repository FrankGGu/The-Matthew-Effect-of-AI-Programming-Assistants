-module(maximize_active_section).
-export([max_active_section/2]).

max_active_section(A, K) ->
    N = length(A),
    max_active_section_helper(A, K, 0, N - 1, 0, 0).

max_active_section_helper(A, K, L, R, WindowSum, MaxSum) ->
    if L > R ->
        MaxSum;
    true ->
        case lists:nth(L + 1, A) of
            0 ->
                if K > 0 ->
                    NewWindowSum = WindowSum + 1,
                    NewK = K - 1,
                    NewMaxSum = max(MaxSum, NewWindowSum),
                    max_active_section_helper(A, NewK, L + 1, R, NewWindowSum, NewMaxSum);
                true ->
                    max_active_section_helper(A, K, L + 1, R, WindowSum, MaxSum)
                end;
            1 ->
                NewWindowSum = WindowSum + 1,
                NewMaxSum = max(MaxSum, NewWindowSum),
                max_active_section_helper(A, K, L + 1, R, NewWindowSum, NewMaxSum)
        end
    end.

max(A, B) ->
    if A > B ->
        A;
    true ->
        B
    end.