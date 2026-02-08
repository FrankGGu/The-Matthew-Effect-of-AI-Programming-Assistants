-module(solution).
-export([num_of_arrays/3]).

num_of_arrays(N, M, K) ->
    MOD = 1_000_000_007,

    % dp_table will store {I, J, L} -> Value for dp[I][J][L]
    % dp[I][J][L] represents the number of arrays of length I,
    % where the maximum element is exactly J, and the cost is exactly L.
    dp_table = ets:new(dp_table, [set, public, {keypos, 1}]),

    % prefix_sum_table will store {I, J, L} -> Value for prefix_sum[I][J][L]
    % prefix_sum[I][J][L] = sum(dp[I][x][L] for x from 1 to J)
    % This is used to efficiently calculate the sum of dp values for new maximums.
    prefix_sum_table = ets:new(prefix_sum_table, [set, public, {keypos, 1}]),

    % Helper function to get value from an ETS table
    get_val(Table, I, J, L) ->
        case ets:lookup(Table, {I, J, L}) of
            [{_, Val}] -> Val;
            [] -> 0
        end.

    % Base case: I = 1 (arrays of length 1)
    % For arr[0] = J, the maximum element is J, and the cost is 1.
    % So, dp[1][J][1] = 1 for J from 1 to M.
    % prefix_sum[1][J][1] = sum(dp[1][x][1] for x from 1 to J) = J.
    lists:foreach(
        fun(J) ->
            ets:insert(dp_table, {{1, J, 1}, 1}),
            ets:insert(prefix_sum_table, {{1, J, 1}, J})
        end,
        lists:seq(1, M)
    ),

    % Main DP loop: Iterate for array lengths from 1 to N-1
    lists:foreach(
        fun(I) -> % I represents the previous length (current length is I+1)
            lists:foreach(
                fun(L_curr) -> % L_curr represents the current cost (for length I+1)
                    lists:foreach(
                        fun(J_curr) -> % J_curr represents the current maximum element (for length I+1)
                            Current_dp_val = 0,

                            % Case 1: The (I+1)-th element (arr[I]) is NOT a new maximum.
                            % This means arr[I] <= J_curr (the current maximum).
                            % The maximum element remains J_curr, and the cost remains L_curr.
                            % We come from dp[I][J_curr][L_curr].
                            % There are J_curr choices for arr[I] (from 1 to J_curr).
                            Val_from_no_new_max = get_val(dp_table, I, J_curr, L_curr),
                            Current_dp_val_after_case1 = (Current_dp_val + Val_from_no_new_max * J_curr) rem MOD,

                            % Case 2: The (I+1)-th element (arr[I]) IS a new maximum.
                            % This means arr[I] = J_curr. The cost increases by 1.
                            % We come from states where the previous maximum was < J_curr and cost was L_curr - 1.
                            % The sum of such states is prefix_sum[I][J_curr - 1][L_curr - 1].
                            Val_from_new_max = 0,
                            if L_curr > 1 -> % L_curr-1 must be at least 1 for a valid previous cost
                                Val_from_new_max = get_val(prefix_sum_table, I, J_curr - 1, L_curr - 1);
                                true -> ok
                            end,
                            Updated_dp_val = (Current_dp_val_after_case1 + Val_from_new_max) rem MOD,

                            % Store the calculated dp[I+1][J_curr][L_curr]
                            ets:insert(dp_table, {{I + 1, J_curr, L_curr}, Updated_dp_val}),

                            % Calculate prefix_sum[I+1][J_curr][L_curr]
                            % It's the sum of prefix_sum[I+1][J_curr-1][L_curr] and dp[I+1][J_curr][L_curr]
                            Prev_prefix_sum_val = get_val(prefix_sum_table, I + 1, J_curr - 1, L_curr),
                            Updated_prefix_sum_val = (Prev_prefix_sum_val + Updated_dp_val) rem MOD,
                            ets:insert(prefix_sum_table, {{I + 1, J_curr, L_curr}, Updated_prefix_sum_val})
                        end,
                        lists:seq(1, M) % Iterate J_curr from 1 to M
                    )
                end,
                lists:seq(1, K) % Iterate L_curr from 1 to K
            )
        end,
        lists:seq(1, N - 1) % Iterate I from 1 to N-1 (up to N-1 because we calculate for I+1)
    ),

    % The final result is the total number of arrays of length N with cost K.
    % This is the sum of dp[N][J][K] for all possible maximums J (from 1 to M).
    % This sum is directly available in prefix_sum[N][M][K].
    TotalWays = get_val(prefix_sum_table, N, M, K),

    % Clean up the ETS tables
    ets:delete(dp_table),
    ets:delete(prefix_sum_table),

    TotalWays.