-module(longest_subarray_with_at_most_k_frequency).
-export([solve/1]).

solve(A) ->
    solve(A, 1).

solve(A, K) ->
    N = length(A),
    solve_helper(A, K, 0, 0, 0, #{}, N).

solve_helper(_A, _K, L, _R, MaxLen, _Freq, N) when L >= N ->
    MaxLen;
solve_helper(A, K, L, R, MaxLen, Freq, N) ->
    if
        R < N ->
            Val = lists:nth(R + 1, A),
            case maps:get(Val, Freq, 0) < K of
                true ->
                    NewFreq = maps:update(Val, maps:get(Val, Freq, 0) + 1, maps:put(Val, 1, Freq)),
                    solve_helper(A, K, L, R + 1, max(MaxLen, R - L + 1), NewFreq, N);
                false ->
                    ValL = lists:nth(L + 1, A),
                    NewFreq = maps:update(ValL, maps:get(ValL, Freq, 0) - 1, Freq),
                    solve_helper(A, K, L + 1, R, MaxLen, NewFreq, N)
            end;
        true ->
            ValL = lists:nth(L + 1, A),
            NewFreq = maps:update(ValL, maps:get(ValL, Freq, 0) - 1, Freq),
            solve_helper(A, K, L + 1, R, MaxLen, NewFreq, N)
    end.