-module(solution).
-export([min_time_to_break_locks/2]).

min_time_to_break_locks(LockTimes, K) ->
    SortedLockTimes = lists:sort(fun(A, B) -> A >= B end, LockTimes),

    WorkerHeap = lists:foldl(
        fun(_, AccHeap) -> gb_trees:insert(0, 0, AccHeap) end,
        gb_trees:empty(),
        lists:seq(1, K)
    ),

    FinalWorkerHeap = lists:foldl(
        fun(LockTime, AccHeap) ->
            {{EarliestFinishTime, _Value}, HeapAfterExtract} = gb_trees:take_smallest(AccHeap),
            NewFinishTime = EarliestFinishTime + LockTime,
            gb_trees:insert(NewFinishTime, NewFinishTime, HeapAfterExtract)
        end,
        WorkerHeap,
        SortedLockTimes
    ),

    {MaxFinishTime, _Value} = gb_trees:get_max(FinalWorkerHeap),
    MaxFinishTime.