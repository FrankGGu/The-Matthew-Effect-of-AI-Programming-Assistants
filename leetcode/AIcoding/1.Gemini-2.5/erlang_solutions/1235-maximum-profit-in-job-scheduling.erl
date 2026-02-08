-module(solution).
-export([jobScheduling/3]).

jobScheduling(StartTime, EndTime, Profit) ->
    N = length(StartTime),

    % Combine job details into a list of tuples: [{StartTime, EndTime, Profit}]
    JobsList = lists:zip3(StartTime, EndTime, Profit),

    % Sort jobs by their start times in ascending order
    SortedJobsList = lists:sort(fun({S1, _, _}, {S2, _, _}) -> S1 =< S2 end, JobsList),

    % Convert the sorted list to an array for O(1) indexed access
    JobsArray = array:from_list(SortedJobsList),

    % Memoization map to store computed maximum profits for subproblems
    Memo = #{},

    % Start the recursive DP solution from the first job (index 0)
    % The solve function returns {MaxProfit, UpdatedMemo}, we only need MaxProfit
    {MaxProfit, _} = solve(0, JobsArray, N, Memo),
    MaxProfit.

solve(Idx, _JobsArray, N, Memo) when Idx >= N ->
    % Base case: If index is out of bounds, no more jobs to schedule, profit is 0.
    {0, Memo};
solve(Idx, JobsArray, N, Memo) ->
    % Check if the result for this Idx is already memoized
    case maps:find(Idx, Memo) of
        {ok, MaxProfit} ->
            {MaxProfit, Memo};
        _ ->
            % Option 1: Don't take the current job (Idx)
            % Move to the next job and get its maximum profit
            {Profit1, Memo1} = solve(Idx + 1, JobsArray, N, Memo),

            % Option 2: Take the current job (Idx)
            {_CurrentS, CurrentE, CurrentP} = array:get(Idx, JobsArray),

            % Find the index of the next job that can be scheduled after CurrentE
            % This is done using binary search on the remaining jobs (from Idx + 1 to N - 1)
            NextJobIdx = find_next_job_index(CurrentE, JobsArray, Idx + 1, N - 1),

            % Get the maximum profit from scheduling jobs starting from NextJobIdx
            {Profit2_rest, Memo2} = solve(NextJobIdx, JobsArray, N, Memo1),

            % Total profit for Option 2: current job's profit + profit from subsequent jobs
            Profit2 = CurrentP + Profit2_rest,

            % Choose the maximum profit between the two options
            MaxProfit = max(Profit1, Profit2),

            % Memoize the result for the current Idx
            NewMemo = maps:put(Idx, MaxProfit, Memo2),
            {MaxProfit, NewMemo}
    end.

find_next_job_index(TargetStartTime, JobsArray, Low, High) ->
    % Initialize ResultIdx to High + 1, which represents "no suitable job found"
    % (or beyond the last valid index, leading to a base case in solve/4)
    ResultIdx = High + 1, 
    find_next_job_index_bs(TargetStartTime, JobsArray, Low, High, ResultIdx).

find_next_job_index_bs(TargetStartTime, _JobsArray, Low, High, ResultIdx) when Low > High ->
    % Base case: search range is invalid, return the best candidate found.
    ResultIdx;
find_next_job_index_bs(TargetStartTime, JobsArray, Low, High, ResultIdx) ->
    Mid = Low + (High - Low) div 2, % Calculate mid-point to prevent overflow
    {MidS, _, _} = array:get(Mid, JobsArray), % Get start time of the job at Mid index

    if
        MidS >= TargetStartTime ->
            % The job at Mid starts after or at TargetStartTime.
            % This is a potential candidate. Try to find an even earlier one in the left half.
            find_next_job_index_bs(TargetStartTime, JobsArray, Low, Mid - 1, Mid);
        true ->
            % The job at Mid starts too early.
            % Look for a suitable job in the right half.
            find_next_job_index_bs(TargetStartTime, JobsArray, Mid + 1, High, ResultIdx)
    end.