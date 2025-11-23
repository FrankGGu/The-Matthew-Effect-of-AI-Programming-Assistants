-module(solution).
-export([max_tasks/4]).

max_tasks(Tasks, Workers, Pills, Strength) ->
    % Sort tasks and workers in ascending order.
    TasksS = lists:sort(Tasks),
    WorkersS = lists:sort(Workers),

    % Convert sorted lists to arrays for O(1) access.
    TasksA = array:from_list(TasksS),
    WorkersA = array:from_list(WorkersS),

    % Binary search for the maximum number of tasks K.
    % K can range from 0 to min(number of tasks, number of workers).
    Low = 0,
    High = min(array:size(TasksA), array:size(WorkersA)),

    binary_search(Low, High, 0, TasksA, WorkersA, Pills, Strength).

binary_search(Low, High, CurrentAns, TasksA, WorkersA, Pills, Strength) ->
    if
        Low > High ->
            CurrentAns;
        true ->
            Mid = Low + (High - Low) div 2,
            if
                Mid == 0 -> % 0 tasks can always be assigned, but we are looking for max > 0
                    binary_search(Mid + 1, High, CurrentAns, TasksA, WorkersA, Pills, Strength);
                check(Mid, TasksA, WorkersA, Pills, Strength) ->
                    % If Mid tasks can be assigned, try for more.
                    binary_search(Mid + 1, High, Mid, TasksA, WorkersA, Pills, Strength);
                true ->
                    % If Mid tasks cannot be assigned, try for fewer.
                    binary_search(Low, Mid - 1, CurrentAns, TasksA, WorkersA, Pills, Strength)
            end
    end.

check(K, TasksA, WorkersA, Pills, Strength) ->
    TaskIdx = 0, % Pointer to the current easiest task to consider from TasksA
    WorkerIdx = array:size(WorkersA) - K, % Pointer to the weakest of the K strongest workers
    PillCandidates = gb_trees:empty(), % Min-heap (gb_trees) to store tasks that can be done with a pill

    NumTasks = array:size(TasksA),
    NumWorkers = array:size(WorkersA),

    % Iterate K times, trying to assign one task in each iteration.
    % We process workers from weakest of the K strongest to strongest.
    % This ensures we use the weakest possible worker for a task, saving stronger workers for harder tasks.
    check_loop(K, TaskIdx, WorkerIdx, Pills, PillCandidates, TasksA, WorkersA, Strength, NumTasks, NumWorkers).

check_loop(0, _TaskIdx, _WorkerIdx, _PillsLeft, _PillCandidates, _TasksA, _WorkersA, _Strength, _NumTasks, _NumWorkers) ->
    true; % All K tasks assigned successfully
check_loop(RemainingTasks, TaskIdx, WorkerIdx, PillsLeft, PillCandidates, TasksA, WorkersA, Strength, NumTasks, NumWorkers) ->
    if
        WorkerIdx >= NumWorkers -> % Not enough workers for K tasks (should not happen if K <= NumWorkers)
            false;
        true ->
            CurrentWorker = array:get(WorkerIdx, WorkersA),

            % Add all tasks that CurrentWorker (or stronger workers) can potentially do (with or without a pill)
            % to the PillCandidates min-heap.
            {NewTaskIdx, NewPillCandidates} = add_tasks_to_candidates(TaskIdx, CurrentWorker, Strength, TasksA, NumTasks, PillCandidates),

            if
                gb_trees:is_empty(NewPillCandidates) ->
                    false; % No tasks available for this worker, even with a pill
                true ->
                    % Get the easiest task from PillCandidates.
                    {SmallestTask, _} = gb_trees:smallest(NewPillCandidates),

                    if
                        CurrentWorker >= SmallestTask ->
                            % Worker can do the easiest task without a pill.
                            UpdatedPillCandidates = gb_trees:delete(SmallestTask, NewPillCandidates),
                            check_loop(RemainingTasks - 1, NewTaskIdx, WorkerIdx + 1, PillsLeft, UpdatedPillCandidates, TasksA, WorkersA, Strength, NumTasks, NumWorkers);
                        PillsLeft > 0 ->
                            % Worker needs a pill for the easiest task and pills are available.
                            UpdatedPillCandidates = gb_trees:delete(SmallestTask, NewPillCandidates),
                            check_loop(RemainingTasks - 1, NewTaskIdx, WorkerIdx + 1, PillsLeft - 1, UpdatedPillCandidates, TasksA, WorkersA, Strength, NumTasks, NumWorkers);
                        true ->
                            false % Worker cannot do the easiest task (needs pill, but no pills left)
                    end
            end
    end.

add_tasks_to_candidates(TaskIdx, CurrentWorker, Strength, TasksA, NumTasks, AccPillCandidates) ->
    if
        TaskIdx < NumTasks andalso array:get(TaskIdx, TasksA) <= CurrentWorker + Strength ->
            Task = array:get(TaskIdx, TasksA),
            NewAccPillCandidates = gb_trees:insert(Task, Task, AccPillCandidates),
            add_tasks_to_candidates(TaskIdx + 1, CurrentWorker, Strength, TasksA, NumTasks, NewAccPillCandidates);
        true ->
            {TaskIdx, AccPillCandidates}
    end.