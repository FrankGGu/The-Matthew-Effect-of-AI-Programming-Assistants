-module(solution).
-export([minimum_time/2]).

minimum_time(Tasks, TimePerTask) ->
    TotalTasks = length(Tasks),
    MaxTime = lists:max(Tasks),
    TotalTime = lists:sum(Tasks) + (TotalTasks - 1) * TimePerTask,
    MaxTime + TotalTime.