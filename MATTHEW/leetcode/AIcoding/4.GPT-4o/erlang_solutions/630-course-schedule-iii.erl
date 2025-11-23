-module(course_schedule_iii).
-export([schedule/1]).

schedule(Courses) ->
    CoursesSorted = lists:sort(fun({D1, T1}, {D2, T2}) -> T1 < T2 end, Courses),
    schedule_helper(CoursesSorted, [], 0).

schedule_helper([], Completed, _) -> 
    length(Completed);
schedule_helper([{Duration, LastDay} | Rest], Completed, CurrentTime) ->
    if 
        CurrentTime + Duration =< LastDay ->
            schedule_helper(Rest, [Duration | Completed], CurrentTime + Duration);
        true ->
            schedule_helper(Rest, Completed, CurrentTime)
    end.