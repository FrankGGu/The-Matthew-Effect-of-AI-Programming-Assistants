-module(solution).
-export([count_winning_sequences/3]).

count_winning_sequences(N, X, Y) ->
    % DpTable stores {I, J, K} -> Count
    % I: length of sequence
    % J: last element value
    % K: sum of sequence
    DpTable = ets:new(dp_table, [set, protected, {read_concurrency, true}]),

    % Base case: a[1] = 1. Length 1, last element 1, sum 1.
    % This is the only winning sequence of length 1.
    ets:insert(DpTable, {{1, 1, 1}, 1}),

    % Iterate for sequence length I from 2 to N
    lists:foreach(fun(I) -> % Current length of sequence
        % K_prev_sum: sum of the first (I-1) elements.
        % It can range from 1 up to Y.
        lists:foreach(fun(K_prev_sum) ->
            % This foldl accumulates the prefix sum for dp[I-1][PrevJ][K_prev_sum]
            % and uses it to calculate dp[I][J][K_current_sum].
            lists:foldl(fun(PrevJ, CurrentPrefixSum) ->
                % PrevJ: value of the (I-1)-th element.
                % It can range from 1 to X.
                ValFromPrevState = get_dp(DpTable, I-1, PrevJ, K_prev_sum),
                NewPrefixSum = CurrentPrefixSum + ValFromPrevState,

                % K_current_sum is the sum of the sequence of length I,
                % where the last element (a[I]) is PrevJ, and the sum of
                % the first (I-1) elements was K_prev_sum.
                K_current_sum = K_prev_sum + PrevJ,

                % Only insert if the current sum does not exceed Y.
                if K_current_sum =< Y ->
                    % Here, PrevJ is the 'J' for the current state {I, J, K_current_sum}.
                    % NewPrefixSum is sum_{x=1 to PrevJ} dp[I-1][x][K_prev_sum].
                    % This is exactly dp[I][PrevJ][K_current_sum].
                    ets:insert(DpTable, {{I, PrevJ, K_current_sum}, NewPrefixSum});
                true ->
                    ok % Sum exceeds Y, no valid sequences for this path.
                end,
                NewPrefixSum % Pass the updated prefix sum to the next iteration
            end, 0, lists:seq(1, X))
        end, lists:seq(1, Y))
    end, lists:seq(2, N)),

    % Sum up all winning sequences of length N, with any last element J and any sum K <= Y.
    TotalWinningSequences = lists:foldl(fun(J, Acc1) ->
        lists:foldl(fun(K, Acc2) ->
            Acc2 + get_dp(DpTable, N, J, K)
        end, Acc1, lists:seq(1, Y))
    end, 0, lists:seq(1, X)),

    ets:delete(dp_table),
    TotalWinningSequences.

get_dp(DpTable, I, J, K) when I >= 1, J >= 1, K >= 1 ->
    case ets:lookup(DpTable, {I, J, K}) of
        [{_, Val}] -> Val;
        [] -> 0
    end;
get_dp(_DpTable, _I, _J, _K) ->
    0.