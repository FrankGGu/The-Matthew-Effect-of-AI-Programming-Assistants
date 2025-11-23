-module(solution).
-export([task_scheduler_ii/2]).

task_scheduler_ii(Tasks, Space) ->
    {Days, _LastExecMap} = lists:foldl(
        fun(Task, {CurrentDay, LastExecMap}) ->
            NextAvailableDay = CurrentDay + 1,
            case maps:find(Task, LastExecMap) of
                {ok, LastExecTime} ->
                    RequiredDayDueToSpace = LastExecTime + Space + 1,
                    ActualExecDay = max(NextAvailableDay, RequiredDayDueToSpace),
                    {ActualExecDay, maps:put(Task, ActualExecDay, LastExecMap)}
                not_found ->
                    {NextAvailableDay, maps:put(Task, NextAvailableDay, LastExecMap)}
            end
        end,
        {0, maps:new()},
        Tasks
    ),
    Days.