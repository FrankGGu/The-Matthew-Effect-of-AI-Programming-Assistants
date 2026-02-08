-module(solution).
-export([process_tasks/1]).

process_tasks(Tasks) ->
    lists:map(fun(Task) -> perform_task(Task) end, Tasks).

perform_task(Task) ->
    % Implement the logic for processing each task here
    Task.