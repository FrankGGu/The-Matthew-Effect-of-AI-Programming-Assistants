-module(task_manager).
-export([init/0, add_task/3, get_tasks/1, cancel_task/2]).

init() ->
    #{}.

add_task(Pid, TaskId, Time) ->
    Pid ! {self(), add, TaskId, Time},
    receive
        {Pid, ok} -> ok
    after 1000 -> timeout
    end.

get_tasks(Pid) ->
    Pid ! {self(), get},
    receive
        {Pid, Tasks} -> Tasks
    after 1000 -> timeout
    end.

cancel_task(Pid, TaskId) ->
    Pid ! {self(), cancel, TaskId},
    receive
        {Pid, ok} -> ok;
        {Pid, not_found} -> not_found
    after 1000 -> timeout
    end.

start_manager() ->
    spawn(fun() -> manager_loop(#{}) end).

manager_loop(Tasks) ->
    receive
        {From, add, TaskId, Time} ->
            NewTasks = maps:put(TaskId, Time, Tasks),
            From ! {self(), ok},
            manager_loop(NewTasks);
        {From, get} ->
            From ! {self(), Tasks},
            manager_loop(Tasks);
        {From, cancel, TaskId} ->
            case maps:is_key(TaskId, Tasks) of
                true ->
                    NewTasks = maps:remove(TaskId, Tasks),
                    From ! {self(), ok},
                    manager_loop(NewTasks);
                false ->
                    From ! {self(), not_found},
                    manager_loop(Tasks)
            end
    end.