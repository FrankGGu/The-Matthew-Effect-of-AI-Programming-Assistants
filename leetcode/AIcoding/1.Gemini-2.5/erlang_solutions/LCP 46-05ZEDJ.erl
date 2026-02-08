-module(solution).
-export([max_tasks/3]).

-include_lib("kernel/include/array.hrl").

max_tasks(Tasks, Workers, P) ->
    SortedTasksList = lists:sort(Tasks),
    SortedWorkersList = lists:sort(Workers),

    SortedTasks = array:from_list(SortedTasksList),
    SortedWorkers = array:from_list(SortedWorkersList),

    N = array:size(SortedTasks),
    M = array:size(SortedWorkers),

    Low = 0,
    High = min(N, M),

    binary_search(Low, High, SortedTasks, SortedWorkers, P, 0).

binary_search(Low, High, SortedTasks, SortedWorkers, P, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case can_complete(Mid, SortedTasks, SortedWorkers, P) of
        true ->
            binary_search(Mid + 1, High, SortedTasks, SortedWorkers, P, Mid);
        false ->
            binary_search(Low, Mid - 1, SortedTasks, SortedWorkers, P, Ans)
    end;
binary_search(_, _, _, _, _, Ans) ->
    Ans.

can_complete(K, SortedTasks, SortedWorkers, P) ->
    if K == 0 ->
        true;
       K > array:size(SortedWorkers) ->
        false;
       true ->
        PillsLeft = P,
        AvailableWorkers = gb_trees:empty(),
        WorkerPtr = array:size(SortedWorkers) - 1, % 0-indexed array index for SortedWorkers, start from strongest
        TaskPtr = K - 1, % 0-indexed array index for SortedTasks, considering K hardest tasks, start from K-1 (hardest of K)

        can_complete_loop(TaskPtr, WorkerPtr, PillsLeft, AvailableWorkers, SortedTasks, SortedWorkers, P)
    end.

can_complete_loop(TaskPtr, WorkerPtr, PillsLeft, AvailableWorkers, SortedTasks, SortedWorkers, P) when TaskPtr >= 0 ->
    CurrentTask = array:get(TaskPtr, SortedTasks), % array:get is 0-indexed

    % Add workers from SortedWorkers (from strongest downwards) that are strong enough for CurrentTask (or stronger)
    % into AvailableWorkers. These workers are now "available" for assignment.
    {NewWorkerPtr, UpdatedAvailableWorkers} = 
        add_workers_for_current_task(WorkerPtr, CurrentTask, AvailableWorkers, SortedWorkers),

    case gb_trees:is_empty(UpdatedAvailableWorkers) of
        true ->
            false; % No workers available (even with pill consideration)
        false ->
            % Try to find a worker without a pill
            Match = gb_trees:lookup_ge(CurrentTask, UpdatedAvailableWorkers),
            case Match of
                {value, WorkerStrength, _} ->
                    % Found a worker strong enough without a pill, use the weakest such worker
                    NewAvailableWorkers = gb_trees:delete(WorkerStrength, UpdatedAvailableWorkers),
                    can_complete_loop(TaskPtr - 1, NewWorkerPtr, PillsLeft, NewAvailableWorkers, SortedTasks, SortedWorkers, P);
                none ->
                    % No worker strong enough without a pill, try with a pill
                    if PillsLeft > 0 ->
                        % Find the strongest worker in AvailableWorkers that can complete the task with a pill
                        % This worker must have strength >= CurrentTask - P
                        % gb_trees:get_max returns {Key, Value}
                        {MaxWorkerStrength, _} = gb_trees:get_max(UpdatedAvailableWorkers),
                        if MaxWorkerStrength + P >= CurrentTask ->
                            NewAvailableWorkers = gb_trees:delete(MaxWorkerStrength, UpdatedAvailableWorkers),
                            can_complete_loop(TaskPtr - 1, NewWorkerPtr, PillsLeft - 1, NewAvailableWorkers, SortedTasks, SortedWorkers, P);
                           true ->
                            false % Cannot complete this task even with a pill (strongest available worker not enough)
                        end;
                       true ->
                        false % No pills left
                    end
            end
    end;
can_complete_loop(_, _, _, _, _, _, _) ->
    true. % All K tasks successfully assigned

add_workers_for_current_task(WorkerPtr, CurrentTask, AvailableWorkers, SortedWorkers) ->
    add_workers_for_current_task_loop(WorkerPtr, CurrentTask, AvailableWorkers, SortedWorkers).

add_workers_for_current_task_loop(WorkerPtr, CurrentTask, AvailableWorkers, SortedWorkers) when WorkerPtr >= 0 ->
    WorkerStrength = array:get(WorkerPtr, SortedWorkers), % array:get is 0-indexed
    if WorkerStrength >= CurrentTask ->
        UpdatedAvailableWorkers = gb_trees:insert(WorkerStrength, true, AvailableWorkers),
        add_workers_for_current_task_loop(WorkerPtr - 1, CurrentTask, UpdatedAvailableWorkers, SortedWorkers);
       true ->
        {WorkerPtr, AvailableWorkers} % This worker is too weak for CurrentTask, and so are all weaker ones
    end;
add_workers_for_current_task_loop(WorkerPtr, _, AvailableWorkers, _) ->
    {WorkerPtr, AvailableWorkers}.