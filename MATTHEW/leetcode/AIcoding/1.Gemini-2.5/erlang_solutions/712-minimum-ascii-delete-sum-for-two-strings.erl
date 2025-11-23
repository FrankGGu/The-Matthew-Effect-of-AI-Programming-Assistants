-module(solution).
-export([minimumDeleteSum/2]).

-include_lib("kernel/include/array.hrl").

minimumDeleteSum(S1, S2) ->
    N = length(S1),
    M = length(S2),

    % Convert S1 and S2 to arrays for O(1) access.
    % Erlang array module is 0-indexed.
    S1_arr = array:from_list(S1),
    S2_arr = array:from_list(S2),

    % Initialize PrevDpRow (dp[0][j] values)
    % PrevDpRow will store the values for the previous row (i-1) in the DP table.
    % It's an array of size M+1, representing dp[i-1][0] to dp[i-1][M].
    PrevDpRow = array:new([{size, M + 1}, {fixed, true}]),

    % Set dp[0][0] = 0
    PrevDpRow_with_0_0 = array:set(0, 0, PrevDpRow),

    % Fill dp[0][j] for j = 1 to M
    % dp[0][j] = dp[0][j-1] + S2[j-1] (ASCII value of S2 character)
    PrevDpRow_init = lists:foldl(
        fun(J, AccArray) ->
            Val = array:get(J - 1, AccArray) + array:get(J - 1, S2_arr),
            array:set(J, Val, AccArray)
        end,
        PrevDpRow_with_0_0,
        lists:seq(1, M) % J is 1-indexed for DP column
    ),

    % Iterate from I = 0 to N-1 (0-indexed for S1_arr) to calculate each CurrentDpRow
    % I_idx corresponds to S1_arr index. The DP row index is I_idx + 1.
    FinalPrevDpRow = lists:foldl(
        fun(I_idx, AccPrevDpRow) -> % AccPrevDpRow holds dp[I_idx][0...M]
            S1Char = array:get(I_idx, S1_arr),
            CurrentDpRow = array:new([{size, M + 1}, {fixed, true}]),

            % Calculate dp[I_idx+1][0] (current_dp_row[0])
            % dp[I_idx+1][0] = dp[I_idx][0] + S1[I_idx]
            CurrentDpRow_0_val = array:get(0, AccPrevDpRow) + S1Char,
            CurrentDpRow_with_0 = array:set(0, CurrentDpRow_0_val, CurrentDpRow),

            % Calculate dp[I_idx+1][J_idx+1] for J_idx = 0 to M-1
            % J_idx corresponds to S2_arr index. The DP column index is J_idx + 1.
            CurrentDpRow_filled = lists:foldl(
                fun(J_idx, AccCurrentDpRow) -> % AccCurrentDpRow holds dp[I_idx+1][0...J_idx]
                    S2Char = array:get(J_idx, S2_arr),

                    % Values needed for dp[I_idx+1][J_idx+1]:
                    % dp[I_idx][J_idx]   -> AccPrevDpRow[J_idx] (diagonal)
                    % dp[I_idx][J_idx+1] -> AccPrevDpRow[J_idx+1] (up)
                    % dp[I_idx+1][J_idx] -> AccCurrentDpRow[J_idx] (left)

                    PrevVal_diag = array:get(J_idx, AccPrevDpRow),
                    PrevVal_up = array:get(J_idx + 1, AccPrevDpRow),
                    PrevVal_left = array:get(J_idx, AccCurrentDpRow),

                    NewVal = if S1Char == S2Char -> PrevVal_diag;
                             true -> min(PrevVal_up + S1Char, PrevVal_left + S2Char)
                             end,
                    array:set(J_idx + 1, NewVal, AccCurrentDpRow)
                end,
                CurrentDpRow_with_0,
                lists:seq(0, M - 1) % J_idx from 0 to M-1
            ),
            CurrentDpRow_filled % This becomes AccPrevDpRow for the next iteration
        end,
        PrevDpRow_init, % Initial AccPrevDpRow is dp[0][0...M]
        lists:seq(0, N - 1) % I_idx from 0 to N-1
    ),

    % The result is dp[N][M], which is the last element of the last calculated row.
    array:get(M, FinalPrevDpRow).