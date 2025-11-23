-module(solution).
-export([assign_volunteers/2]).

assign_volunteers(Volunteers, Tasks) ->
    lists:map(fun(Task) -> assign_to_task(Task, Volunteers) end, Tasks).

assign_to_task(Task, Volunteers) ->
    case lists:filter(fun({V}) -> V >= Task end, Volunteers) of
        [] -> -1;
        Available -> hd(Available)
    end.