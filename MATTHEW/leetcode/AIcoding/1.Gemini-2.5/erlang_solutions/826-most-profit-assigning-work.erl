-module(solution).
-export([maxProfitAssignment/3]).

maxProfitAssignment(Difficulty, Profit, Worker) ->
    Jobs = lists:zip(Difficulty, Profit),
    SortedJobs = lists:sort(fun({D1, _}, {D2, _}) -> D1 =< D2 end, Jobs),
    SortedWorkers = lists:sort(fun(A1, A2) -> A1 =< A2 end, Worker),

    solve(SortedWorkers, SortedJobs, 0, 0).

solve([], _RemainingJobs, AccumulatedTotalProfit, _MaxProfitFromJobsSeenSoFar) ->
    AccumulatedTotalProfit;
solve([WorkerAbility | RestWorkers], Jobs, AccumulatedTotalProfit, MaxProfitFromJobsSeenSoFar) ->
    {NewMaxProfitFromJobsSeenSoFar, RemainingJobsAfterProcessing} = 
        process_jobs(WorkerAbility, Jobs, MaxProfitFromJobsSeenSoFar),

    solve(RestWorkers, RemainingJobsAfterProcessing, AccumulatedTotalProfit + NewMaxProfitFromJobsSeenSoFar, NewMaxProfitFromJobsSeenSoFar).

process_jobs(_WorkerAbility, [], CurrentMaxProfit) ->
    {CurrentMaxProfit, []};
process_jobs(WorkerAbility, [{JobD, JobP} | RestJobs], CurrentMaxProfit) ->
    if
        JobD =< WorkerAbility ->
            process_jobs(WorkerAbility, RestJobs, max(CurrentMaxProfit, JobP));
        true ->
            {CurrentMaxProfit, [{JobD, JobP} | RestJobs]}
    end.