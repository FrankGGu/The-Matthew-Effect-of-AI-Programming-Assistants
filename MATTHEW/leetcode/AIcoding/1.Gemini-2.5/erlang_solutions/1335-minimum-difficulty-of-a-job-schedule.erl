-module(solution).
-export([min_difficulty/2]).

min_difficulty(Jobs, D) ->
    N = length(Jobs),

    % If it's impossible to schedule one job per day
    if N < D ->
        -1;
    true ->
        % Max possible difficulty sum is 300 * 1000 = 300,000. Use a larger value for infinity.
        Infinity = 1_000_000_000, 

        % DP_table is an array of arrays.
        % Outer array for days (1 to D), inner arrays for job counts (1 to N).
        % We use 1-indexed for days and job counts.
        % So DP_table will have size D+1, and each inner array size N+1.

        % Initialize outer array for days (index 0 unused)
        DP_table = array:new([{size, D + 1}, {default, []}]),

        % Initialize inner arrays for job counts (index 0 unused)
        DP_table_initialized = 
            lists:foldl(fun(K, AccDP) ->
                            array:set(K, array:new([{size, N + 1}, {default, Infinity}]), AccDP)
                        end, DP_table, lists:seq(1, D)),

        % Convert Jobs list to an array for O(1) access
        Jobs_array = array:from_list(Jobs),

        % Fill DP for the first day (k=1)
        % dp[1][i] = max difficulty of jobs[0...i-1]
        FirstDayDP_row = array:get(1, DP_table_initialized), % Get the array for day 1

        {_FinalMax, FirstDayDP_row_filled} = 
            lists:foldl(fun(I, {CurrentMax, AccRow}) ->
                            JobDifficulty = array:get(I-1, Jobs_array), % Jobs_array is 0-indexed
                            NewMax = max(CurrentMax, JobDifficulty),
                            {NewMax, array:set(I, NewMax, AccRow)}
                        end, {0, FirstDayDP_row}, lists:seq(1, N)),

        DP_table_updated_1 = array:set(1, FirstDayDP_row_filled, DP_table_initialized),

        % Fill DP for subsequent days
        FinalDP_table = fill_subsequent_days_dp(2, D, N, Jobs_array, DP_table_updated_1, Infinity),

        array:get(N, array:get(D, FinalDP_table))
    end.

fill_subsequent_days_dp(K, D, N, Jobs_array, DP_table, Infinity) ->
    if K > D ->
        DP_table;
    true ->
        PrevDayDP_row = array:get(K-1, DP_table), % Get array for day K-1
        CurrentDayDP_row_init = array:get(K, DP_table), % Get array for day K, initialized with Infinity

        CurrentDayDP_row_filled = lists:foldl(fun(I, AccCurrentDayDP_row) ->
                                    % I is the total number of jobs considered (from 1 to N)
                                    % We need at least K jobs for K days, so I >= K

                                    MinTotalDifficultyFor_I_Jobs = Infinity,
                                    CurrentMaxDifficultyForSegment = 0, % Max difficulty for segment jobs[J_idx ... I-1]

                                    % J_idx is the 0-indexed array index of the first job on the current day K.
                                    % jobs[J_idx ... I-1] are for day K.
                                    % jobs[0 ... J_idx-1] are for days 1 to K-1.
                                    % The number of jobs for previous K-1 days is J_idx.
                                    % We need dp[K-1][J_idx].
                                    % J_idx ranges from K-1 (minimum jobs for K-1 days) to I-1 (if day K takes only 1 job).

                                    % Loop for J_idx (0-indexed job index where the current day's segment starts)
                                    % J_idx goes from I-1 down to K-1

                                    {MinTotalDifficulty_final, _} = 
                                        lists:foldl(fun(J_idx, {MinAcc, MaxSegAcc}) ->
                                                        % Job at J_idx is the first job of the current day's segment
                                                        % The segment is jobs[J_idx ... I-1]
                                                        % MaxSegAcc accumulates max from jobs[I-1] down to jobs[J_idx]

                                                        JobDifficulty = array:get(J_idx, Jobs_array), % Jobs_array is 0-indexed
                                                        NewMaxSegAcc = max(MaxSegAcc, JobDifficulty),

                                                        % Previous day's total difficulty for J_idx jobs
                                                        % dp[K-1][J_idx]
                                                        PrevDayTotalDifficulty = array:get(J_idx, PrevDayDP_row), 

                                                        if PrevDayTotalDifficulty =:= Infinity ->
                                                            {MinAcc, NewMaxSegAcc};
                                                        true ->
                                                            {min(MinAcc, PrevDayTotalDifficulty + NewMaxSegAcc), NewMaxSegAcc}
                                                        end
                                                    end, {MinTotalDifficultyFor_I_Jobs, CurrentMaxDifficultyForSegment}, lists:seq(I-1, K-1, -1)),

                                    array:set(I, MinTotalDifficulty_final, AccCurrentDayDP_row)
                                end, CurrentDayDP_row_init, lists:seq(K, N)),

        UpdatedDP_table = array:set(K, CurrentDayDP_row_filled, DP_table),
        fill_subsequent_days_dp(K + 1, D, N, Jobs_array, UpdatedDP_table, Infinity)
    end.