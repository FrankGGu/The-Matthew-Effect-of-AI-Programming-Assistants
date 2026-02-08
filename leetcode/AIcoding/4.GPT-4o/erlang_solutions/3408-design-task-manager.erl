-module(TaskManager).
-export([new/0, add_task/2, remove_task/1, get_next_task/0]).

-record(task, {id, priority}).

new() ->
    {ok, spawn(fun loop/0)}.

add_task(Pid, TaskId, Priority) ->
    Pid ! {add_task, #task{id=TaskId, priority=Priority}}.

remove_task(Pid, TaskId) ->
    Pid ! {remove_task, TaskId}.

get_next_task(Pid) ->
    Pid ! get_next_task,
    receive
        {next_task, Task} -> Task
    end.

loop() ->
    Tasks = [],
    loop(Tasks).

loop(Tasks) ->
    receive
        {add_task, Task} ->
            NewTasks = [Task | Tasks],
            loop(NewTasks);
        {remove_task, TaskId} ->
            NewTasks = lists:filter(fun(Task) -> Task#task.id =/= TaskId end, Tasks),
            loop(NewTasks);
        get_next_task ->
            Task = lists:foldl(fun(Task, Best) ->
                case Best of
                    none -> {Task, Task#task.priority};
                    {BestTask, BestPriority} when Task#task.priority > BestPriority -> {Task, Task#task.priority};
                    _ -> Best
                end
            end, none, Tasks),
            case Task of
                none -> loop(Tasks);
                {BestTask, _} -> 
                    self() ! {next_task, BestTask},
                    NewTasks = lists:filter(fun(Task) -> Task#task.id =/= BestTask#task.id end, Tasks),
                    loop(NewTasks)
            end
    end.