-module(solution).
-export([process_tasks/3]).

process_tasks(N, tasks, servers) ->
    lists:map(fun(Task) -> process_task(Task, N, servers) end, tasks).

process_task(Task, N, Servers) ->
    ServerIndex = lists:nth(Task rem N + 1, Servers),
    {ServerIndex, Task}.