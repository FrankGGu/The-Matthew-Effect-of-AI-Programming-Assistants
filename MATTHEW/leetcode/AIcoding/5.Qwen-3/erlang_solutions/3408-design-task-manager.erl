-module(task_manager).
-export([new/0, add_task/3, get_next/1, size/1]).

new() ->
    {[], 0}.

add_task(TaskId, Priority, Time) ->
    {Priority, TaskId, Time}.

get_next({Tasks, _}) ->
    case Tasks of
        [] -> none;
        _ ->
            [Next | Rest] = lists:sort(Tasks),
            {Next, {Rest, length(Rest)}}
    end.

size({_, Count}) ->
    Count.