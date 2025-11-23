-module(solution).
-export([get_order/1]).

get_order(Tasks) ->
    IndexedTasks = lists:zipwith(fun(Task, Idx) ->
                                        {element(1, Task), element(2, Task), Idx}
                                end, Tasks, lists:seq(0, length(Tasks) - 1)),
    SortedTasks = lists:sort(fun({ET1, _, _}, {ET2, _, _}) ->
                                     ET1 =< ET2
                             end, IndexedTasks),

    solve(SortedTasks, 0, gb_trees:empty(), []).

solve(PendingTasks, CurrentTime, AvailableTasksHeap, ResultAcc) ->
    {RemainingPendingTasks, EnqueuedHeap} = enqueue_tasks(PendingTasks, CurrentTime, AvailableTasksHeap),

    case {gb_trees:is_empty(EnqueuedHeap), RemainingPendingTasks == []} of
        {true, true} ->
            lists:reverse(ResultAcc);

        {true, false} ->
            {NextEnqueueTime, _, _} = hd(RemainingPendingTasks),
            solve(RemainingPendingTasks, NextEnqueueTime, EnqueuedHeap, ResultAcc);

        {false, _} ->
            {{ProcessingTime, OriginalIndex}, _} = gb_trees:smallest(EnqueuedHeap),

            UpdatedHeap = gb_trees:delete({{ProcessingTime, OriginalIndex}}, EnqueuedHeap),

            NewCurrentTime = CurrentTime + ProcessingTime,

            solve(RemainingPendingTasks, NewCurrentTime, UpdatedHeap, [OriginalIndex | ResultAcc])
    end.

enqueue_tasks(PendingTasks, CurrentTime, AvailableTasksHeap) ->
    if
        PendingTasks == [] ->
            {PendingTasks, AvailableTasksHeap};
        true ->
            {EnqueueTime, ProcessingTime, OriginalIndex} = hd(PendingTasks),
            if
                EnqueueTime =< CurrentTime ->
                    NewHeap = gb_trees:insert({{ProcessingTime, OriginalIndex}, OriginalIndex}, AvailableTasksHeap),
                    enqueue_tasks(tl(PendingTasks), CurrentTime, NewHeap);
                true ->
                    {PendingTasks, AvailableTasksHeap}
            end
    end.