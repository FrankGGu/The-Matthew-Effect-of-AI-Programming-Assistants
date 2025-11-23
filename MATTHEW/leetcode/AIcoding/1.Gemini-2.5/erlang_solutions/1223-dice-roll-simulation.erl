-module(solution).
-export([dieSimulator/2]).

dieSimulator(N, RollMax) ->
    Mod = 1000000007,

    % dp[i][j] represents the number of sequences of length i ending with roll (j+1).
    % The outer list index corresponds to sequence length i (0 to N).
    % The inner list index corresponds to roll j (0 to 5).
    % Initialize dp with N+1 rows, each row having 6 zeros.
    % We use 1-based indexing for lists in Erlang, so index i corresponds to length i.
    Dp = lists:duplicate(N + 1, lists:duplicate(6, 0)),

    % sum_dp[i] represents the total number of sequences of length i.
    % Initialize sum_dp with N+1 zeros.
    SumDp = lists:duplicate(N + 1, 0),

    % Base case: sum_dp[0] = 1 (represents an empty sequence).
    % Update SumDp at index 1 (corresponding to conceptual index 0).
    InitialSumDp = lists:replace_nth(1, 1, SumDp),

    % Iterate from length 1 to N to fill DP table.
    {_FinalDp, FinalSumDp} = 
        lists:foldl(fun(I, {CurrentDp, CurrentSumDp}) ->
            NewRowDp = lists:duplicate(6, 0), % This will store dp[I][j] for j=0 to 5
            CurrentSumForI = 0,

            % Iterate for each possible last roll (j from 0 to 5)
            {UpdatedNewRowDp, UpdatedCurrentSumForI} = 
                lists:foldl(fun(J, {AccNewRowDp, AccCurrentSum}) ->
                    % Get sum_dp[I-1] (total sequences of length I-1)
                    PrevSumDp = lists:nth(I, CurrentSumDp),

                    % dp[I][J] initially considers all sequences of length I-1
                    % can be extended by roll (J+1).
                    CurrentDpIJ = PrevSumDp,

                    % K is the number of consecutive rolls (J+1) that would make a sequence invalid.
                    % rollMax[J] is the maximum allowed consecutive rolls of (J+1).
                    % So, K = rollMax[J] + 1.
                    K = lists:nth(J + 1, RollMax) + 1,

                    SubtractedValue = 0,
                    IfIndex = I - K, % Conceptual index for sum_dp and dp to subtract from

                    if
                        IfIndex >= 0 ->
                            % Get sum_dp[IfIndex]
                            SumDpIK = lists:nth(IfIndex + 1, CurrentSumDp),
                            % Get dp[IfIndex][J]
                            DpIKJ = lists:nth(J + 1, lists:nth(IfIndex + 1, CurrentDp)),

                            % The number of sequences of length IfIndex that do NOT end with (J+1)
                            % This is the amount to subtract, as these sequences, when followed by K consecutive (J+1)s,
                            % would form an invalid sequence of length I.
                            SubtractedValue = (SumDpIK - DpIKJ + Mod) rem Mod;
                        true ->
                            % If IfIndex < 0, no sequence of length IfIndex exists, so no subtraction needed.
                            SubtractedValue = 0
                    end,

                    % Apply subtraction and keep result within modulo range
                    FinalDpIJ = (CurrentDpIJ - SubtractedValue + Mod) rem Mod,

                    % Update the NewRowDp for the current J
                    AccNewRowDpUpdated = lists:replace_nth(J + 1, FinalDpIJ, AccNewRowDp),
                    % Add FinalDpIJ to the total sum for length I
                    AccCurrentSumUpdated = (AccCurrentSum + FinalDpIJ) rem Mod,
                    {AccNewRowDpUpdated, AccCurrentSumUpdated}
                end, {NewRowDp, CurrentSumForI}, lists:seq(0, 5)),

            % Update the Dp table for length I
            NextDp = lists:replace_nth(I + 1, UpdatedNewRowDp, CurrentDp),
            % Update the SumDp table for length I
            NextSumDp = lists:replace_nth(I + 1, UpdatedCurrentSumForI, CurrentSumDp),

            {NextDp, NextSumDp}
        end, {Dp, InitialSumDp}, lists:seq(1, N)),

    % The final answer is sum_dp[N] (which is at index N+1 in FinalSumDp list).
    lists:nth(N + 1, FinalSumDp).