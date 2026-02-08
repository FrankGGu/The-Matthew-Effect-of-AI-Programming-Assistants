-module(solution).
-export([minimumTimeRequired/2]).

minimumTimeRequired(Jobs, K) ->
    N = length(Jobs),
    if K >= N ->
        lists:max(Jobs);
    true ->
        SortedJobs = lists:sort(fun(A, B) -> A >= B end, Jobs),
        InitialWorkerLoads = lists:duplicate(K, 0),
        solve(SortedJobs, K, 0, InitialWorkerLoads, 1_000_000_000)
    end.

solve(Jobs, K, JobIdx, WorkerLoads, CurrentMinMax) ->
    if JobIdx == length(Jobs) ->
        lists:max(WorkerLoads);
    true ->
        Job = lists:nth(JobIdx + 1, Jobs),
        find_min_over_workers(0, K, Job, Jobs, K, JobIdx, WorkerLoads, CurrentMinMax, false)
    end.

find_min_over_workers(WorkerCurrentIdx, K, Job, Jobs, NumWorkers, JobIdx, WorkerLoads, AccMinMax, SeenEmptyWorker) ->
    if WorkerCurrentIdx == K ->
        AccMinMax;
    true ->
        WorkerLoad = lists:nth(WorkerCurrentIdx + 1, WorkerLoads),
        ShouldSkip = (WorkerLoad == 0 andalso SeenEmptyWorker),

        if ShouldSkip ->
            find_min_over_workers(WorkerCurrentIdx + 1, K, Job, Jobs, NumWorkers, JobIdx, WorkerLoads, AccMinMax, SeenEmptyWorker);
        true ->
            NewWorkerLoads = update_worker_load_at_index(WorkerLoads, WorkerCurrentIdx, Job),

            CurrentMaxLoadForThisPath = lists:max(NewWorkerLoads),

            NewSeenEmptyWorker = SeenEmptyWorker orelse (WorkerLoad == 0),

            ResultForThisWorker = 
                if CurrentMaxLoadForThisPath >= AccMinMax ->
                    AccMinMax;
                true ->
                    solve(Jobs, NumWorkers, JobIdx + 1, NewWorkerLoads, AccMinMax)
                end,

            NewAccMinMax = min(AccMinMax, ResultForThisWorker),

            find_min_over_workers(WorkerCurrentIdx + 1, K, Job, Jobs, NumWorkers, JobIdx, WorkerLoads, NewAccMinMax, NewSeenEmptyWorker)
        end
    end.

update_worker_load_at_index(Loads, Index, Job) ->
    lists:replace_nth(Index + 1, lists:nth(Index + 1, Loads) + Job, Loads).