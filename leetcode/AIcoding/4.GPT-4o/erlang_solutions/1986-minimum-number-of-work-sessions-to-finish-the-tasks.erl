-module(solution).
-export([min_sessions/2]).

min_sessions(Tasks, SessionTime) ->
    TasksList = lists:sort(Tasks, >=),
    min_sessions_helper(TasksList, SessionTime, 0).

min_sessions_helper([], _, Sessions) ->
    Sessions;
min_sessions_helper(Tasks, SessionTime, Sessions) ->
    {ToDo, Remaining} = get_tasks(Tasks, SessionTime),
    min_sessions_helper(Remaining, SessionTime, Sessions + 1).

get_tasks([], _) ->
    {[], []};
get_tasks([H | T], SessionTime) ->
    case H =< SessionTime of
        true -> 
            { [H | RemainingTasks], Remaining } = get_tasks(T, SessionTime - H),
            { [H | RemainingTasks], Remaining };
        false -> 
            { [], [H | T] }
    end.