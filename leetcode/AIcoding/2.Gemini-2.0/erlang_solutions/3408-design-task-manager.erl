-module(task_manager).
-export([start/0, submit_task/2, get_task_status/1]).

-record(task, {id, description, status, result}).

start() ->
    spawn(fun() -> loop([]) end).

submit_task(Pid, Description) ->
    Pid ! {submit, Description},
    ok.

get_task_status(Pid, TaskId) ->
    Pid ! {status, TaskId},
    receive
        {status, TaskId, Status} ->
            Status
    end.

loop(Tasks) ->
    receive
        {submit, Description} ->
            TaskId = erlang:unique_integer([positive]),
            NewTask = #task{id = TaskId, description = Description, status = pending, result = undefined},
            spawn(fun() -> execute_task(TaskId, Description) end),
            loop([NewTask | Tasks]);
        {status, TaskId} ->
            case lists:keyfind(TaskId, #task.id, Tasks) of
                false ->
                    self() ! {status, TaskId, not_found};
                Task ->
                    self() ! {status, TaskId, Task#task.status}
            end,
            loop(Tasks);
        {task_done, TaskId, Result} ->
            NewTasks = lists:map(fun(Task) ->
                                         if Task#task.id == TaskId then
                                             Task#task{status = completed, result = Result}
                                         else
                                             Task
                                         end
                                 end, Tasks),
            loop(NewTasks)
    end.

execute_task(TaskId, Description) ->
    % Simulate task execution
    timer:sleep(rand:uniform(1000)),
    Result = process_task(Description),
    whereis(task_manager) ! {task_done, TaskId, Result}.

process_task(Description) ->
    % Simple example: reverse the description string
    lists:reverse(Description).