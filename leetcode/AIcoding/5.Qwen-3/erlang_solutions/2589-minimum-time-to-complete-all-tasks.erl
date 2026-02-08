-module(minimum_time_to_complete_all_tasks).
-export([doAllTasks/1]).

doAllTasks(Tasks) ->
    doAllTasks(Tasks, 0, 0, 0, dict:new()).

doAllTasks([], _, _, _, _) ->
    0;
doAllTasks([{Start, End, Duration} | T], CurrentTime, MaxTime, NextId, IdMap) ->
    Id = NextId,
    case dict:find(Id, IdMap) of
        {ok, ExistingEnd} ->
            if
                CurrentTime >= ExistingEnd ->
                    NewCurrentTime = CurrentTime + Duration,
                    doAllTasks(T, NewCurrentTime, max(MaxTime, NewCurrentTime), NextId + 1, dict:store(Id, NewCurrentTime, IdMap));
                true ->
                    NewCurrentTime = ExistingEnd + Duration,
                    doAllTasks(T, NewCurrentTime, max(MaxTime, NewCurrentTime), NextId + 1, dict:store(Id, NewCurrentTime, IdMap))
            end;
        error ->
            NewCurrentTime = max(CurrentTime, Start) + Duration,
            doAllTasks(T, NewCurrentTime, max(MaxTime, NewCurrentTime), NextId + 1, dict:store(Id, NewCurrentTime, IdMap))
    end.