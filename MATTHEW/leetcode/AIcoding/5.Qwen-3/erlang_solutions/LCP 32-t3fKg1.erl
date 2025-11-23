-module(solution).
-export([process_tasks/1]).

process_tasks(Tasks) ->
    process_tasks(Tasks, 0, 0).

process_tasks([], _Time, Result) ->
    Result;
process_tasks([Task | Rest], Time, Result) ->
    [Start, End, Duration] = Task,
    if
        Start >= Time ->
            NewTime = Time + Duration,
            process_tasks(Rest, NewTime, Result + 1);
        true ->
            process_tasks(Rest, Time, Result)
    end.