-spec max_task_assign(Tasks :: [integer()], Workers :: [integer()], Pills :: integer(), Strength :: integer()) -> integer().
max_task_assign(Tasks, Workers, Pills, Strength) ->
    SortedTasks = lists:sort(Tasks),
    SortedWorkers = lists:sort(Workers),
    N = length(Tasks),
    M = length(Workers),
    K = min(N, M),
    Low = 0,
    High = K,
    binary_search(SortedTasks, SortedWorkers, Pills, Strength, Low, High).

binary_search(Tasks, Workers, Pills, Strength, Low, High) when Low =< High ->
    Mid = (Low + High) div 2,
    case can_assign(Tasks, Workers, Pills, Strength, Mid) of
        true -> binary_search(Tasks, Workers, Pills, Strength, Mid + 1, High);
        false -> binary_search(Tasks, Workers, Pills, Strength, Low, Mid - 1)
    end;
binary_search(_Tasks, _Workers, _Pills, _Strength, Low, _High) ->
    Low.

can_assign(Tasks, Workers, Pills, Strength, K) ->
    TaskSub = lists:sublist(Tasks, K),
    WorkerSub = lists:sublist(Workers, length(Workers) - K + 1, K),
    can_assign_helper(TaskSub, WorkerSub, Pills, Strength).

can_assign_helper([], [], _Pills, _Strength) ->
    true;
can_assign_helper([T | Ts], [W | Ws], Pills, Strength) ->
    if
        W >= T -> can_assign_helper(Ts, Ws, Pills, Strength);
        Pills > 0 andalso (W + Strength) >= T -> can_assign_helper(Ts, Ws, Pills - 1, Strength);
        true -> false
    end.