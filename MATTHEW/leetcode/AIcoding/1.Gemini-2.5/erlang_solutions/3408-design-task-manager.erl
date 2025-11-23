-module(task_manager).
-export([new/0, addTask/4, getNextTask/1, completeTask/2]).

new() ->
    #{tasks_by_id => maps:new(), active_tasks_by_time => gb_trees:empty()}.

addTask(State, TaskId, TaskName, ExecutionTime) ->
    TasksById = maps:get(tasks_by_id, State),
    ActiveTasksByTime = maps:get(active_tasks_by_time, State),

    NewActiveTasksByTime0 = case maps:find(TaskId, TasksById) of
        {ok, #{time := OldExecutionTime, status := active}} ->
            gb_trees:delete({OldExecutionTime, TaskId}, ActiveTasksByTime);
        _ ->
            ActiveTasksByTime
    end,

    NewTasksById = maps:put(TaskId, #{name => TaskName, time => ExecutionTime, status => active}, TasksById),
    FinalActiveTasksByTime = gb_trees:insert({ExecutionTime, TaskId}, true, NewActiveTasksByTime0),
    State#{tasks_by_id => NewTasksById, active_tasks_by_time => FinalActiveTasksByTime}.

getNextTask(State) ->
    ActiveTasksByTime = maps:get(active_tasks_by_time, State),
    case gb_trees:is_empty(ActiveTasksByTime) of
        true -> none;
        false ->
            {{ExecutionTime, TaskId}, _Value} = gb_trees:smallest(ActiveTasksByTime),
            {TaskId, ExecutionTime}
    end.

completeTask(State, TaskId) ->
    TasksById = maps:get(tasks_by_id, State),
    case maps:find(TaskId, TasksById) of
        {ok, #{time := ExecutionTime, status := active} = TaskInfo} ->
            NewTasksById = maps:put(TaskId, TaskInfo#{status => completed}, TasksById),
            NewActiveTasksByTime = gb_trees:delete({ExecutionTime, TaskId}, maps:get(active_tasks_by_time, State)),
            State#{tasks_by_id => NewTasksById, active_tasks_by_time => NewActiveTasksByTime};
        _ ->
            State
    end.