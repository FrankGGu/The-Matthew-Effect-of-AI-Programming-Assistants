-module(solution).
-export([minDifficulty/2]).

minDifficulty(JobDifficulty, D) ->
    N = length(JobDifficulty),

    if
        N < D -> -1;
        true ->
            Infinity = 1_000_000_000, % A sufficiently large number

            % Initialize DP table with infinity
            % DP is an array of arrays. DP[day_idx][job_end_idx]
            % day_idx from 0 to D-1, job_end_idx from 0 to N-1
            % dp[d_idx][n_idx] stores min difficulty for first n_idx+1 jobs in d_idx+1 days
            DP = array:new([{fixed, true}, {size, D}]),
            DP_filled = fill_dp_array(DP, D, N, Infinity),

            % Base case: first day (day 0)
            % dp[0][i] = max difficulty of jobs 0 to i
            DP_with_first_day = calculate_first_day(JobDifficulty, N, DP_filled),

            % Fill DP table for subsequent days
            ResultDP = calculate_subsequent_days(JobDifficulty, N, D, DP_with_first_day, Infinity),

            % The result is dp[D-1][N-1]
            array:get(N-1, array:get(D-1, ResultDP))
    end.

fill_dp_array(DP, D, N, Infinity) ->
    lists:foldl(fun(DayIdx, AccDP) ->
        Row = array:new([{fixed, true}, {size, N}, {default, Infinity}]),
        array:set(DayIdx, Row, AccDP)
    end, DP, lists:seq(0, D-1)).

calculate_first_day(JobDifficulty, N, DP) ->
    MaxDiff = 0,
    Row = array:get(0, DP), % Get the first day's row
    {UpdatedRow, _} = lists:foldl(fun(JobEndIdx, {AccRow, CurrentMaxDiff}) ->
        JobDiff = lists:nth(JobEndIdx + 1, JobDifficulty), % lists:nth is 1-indexed
        NewMaxDiff = max(CurrentMaxDiff, JobDiff),
        NewAccRow = array:set(JobEndIdx, NewMaxDiff, AccRow),
        {NewAccRow, NewMaxDiff}
    end, {Row, MaxDiff}, lists:seq(0, N-1)),
    array:set(0, UpdatedRow, DP).

calculate_subsequent_days(JobDifficulty, N, D, DP, Infinity) ->
    lists:foldl(fun(DayIdx, AccDP_Day) -> % DayIdx is 0-indexed, so it's day DayIdx+1
        % JobEndIdx is the 0-indexed end of the current day's jobs.
        % We need at least DayIdx+1 jobs for DayIdx+1 days.
        % So JobEndIdx must be at least DayIdx.
        lists:foldl(fun(JobEndIdx, AccDP_JobEnd) ->
            CurrentDayRow = array:get(DayIdx, AccDP_JobEnd),
            MinDifficultyForCurrentState = Infinity,
            CurrentDayMaxDiff = 0, % Max difficulty for the current day's jobs (from JobStartIdx to JobEndIdx)

            % Iterate backwards for JobStartIdx
            % JobStartIdx is the 0-indexed start of jobs for the current day.
            % The previous DayIdx days must have scheduled jobs up to JobStartIdx-1.
            % So JobStartIdx must be at least DayIdx.
            % JobStartIdx goes from JobEndIdx down to DayIdx.
            {NewMinDifficulty, _FinalMaxDiffForCurrentDay} =
                lists:foldl(fun(JobStartIdx, {MinDiffAcc, MaxDiffAcc}) ->
                    JobDiff = lists:nth(JobStartIdx + 1, JobDifficulty),
                    UpdatedMaxDiffAcc = max(MaxDiffAcc, JobDiff),

                    % Difficulty for DayIdx-1 days ending at JobStartIdx-1
                    PrevDayRow = array:get(DayIdx - 1, AccDP_JobEnd),
                    PrevDayDifficulty = array:get(JobStartIdx - 1, PrevDayRow),

                    % If PrevDayDifficulty is Infinity, this path is invalid
                    IfPrevDayValid = if PrevDayDifficulty == Infinity -> Infinity; true -> PrevDayDifficulty + UpdatedMaxDiffAcc end,
                    {min(MinDiffAcc, IfPrevDayValid), UpdatedMaxDiffAcc}
                end, {MinDifficultyForCurrentState, CurrentDayMaxDiff}, lists:seq(JobEndIdx, DayIdx, -1)),

            UpdatedCurrentDayRow = array:set(JobEndIdx, NewMinDifficulty, CurrentDayRow),
            array:set(DayIdx, UpdatedCurrentDayRow, AccDP_JobEnd)
        end, AccDP_Day, lists:seq(DayIdx, N-1)) % JobEndIdx iterates from DayIdx to N-1
    end, DP, lists:seq(1, D-1)). % DayIdx iterates from 1 to D-1 (for day 2 to D)