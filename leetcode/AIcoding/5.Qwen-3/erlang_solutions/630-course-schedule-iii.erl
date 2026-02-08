-module(course_schedule_iii).
-export([schedule_course/1]).

schedule_course(Courses) ->
    schedule_course(Courses, 0, []).

schedule_course([], _Time, _Heap) ->
    length(_Heap);
schedule_course([Course | Rest], Time, Heap) ->
    {Duration, Deadline} = Course,
    if
        Time + Duration =< Deadline ->
            schedule_course(Rest, Time + Duration, [Duration | Heap]);
        true ->
            case Heap of
                [] ->
                    schedule_course(Rest, Time, Heap);
                _ ->
                    MaxDuration = lists:max(Heap),
                    if
                        Duration < MaxDuration ->
                            NewHeap = lists:delete(MaxDuration, Heap) ++ [Duration],
                            schedule_course(Rest, Time, NewHeap);
                        true ->
                            schedule_course(Rest, Time, Heap)
                    end
            end
    end.