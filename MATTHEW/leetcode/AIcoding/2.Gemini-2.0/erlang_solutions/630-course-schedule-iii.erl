-module(course_schedule_iii).
-export([schedule_course/1]).

schedule_course(Courses) ->
  schedule_course(Courses, 0, orddict:new()).

schedule_course([], Time, _) ->
  0;
schedule_course(Courses, Time, Schedule) ->
  SortedCourses = lists:sort(fun({_, D1}, {_, D2}) -> D1 < D2 end, Courses),
  schedule_course_helper(SortedCourses, Time, Schedule, 0).

schedule_course_helper([], _, _, Count) ->
  Count;
schedule_course_helper([{Duration, Deadline} | Rest], Time, Schedule, Count) ->
  case Time + Duration =< Deadline of
    true ->
      NewSchedule = orddict:store(Duration, Duration, Schedule),
      schedule_course_helper(Rest, Time + Duration, NewSchedule, Count + 1);
    false ->
      case orddict:is_key(Duration, Schedule) of
        true ->
          schedule_course_helper(Rest, Time, Schedule, Count);
        false ->
          case orddict:size(Schedule) > 0 of
            true ->
              {MaxDuration, _} = orddict:fetch(orddict:max_key(Schedule), Schedule),
              case Duration < MaxDuration of
                true ->
                  NewSchedule = orddict:erase(MaxDuration, Schedule),
                  NewSchedule2 = orddict:store(Duration, Duration, NewSchedule),
                  schedule_course_helper(Rest, Time - MaxDuration + Duration, NewSchedule2, Count);
                false ->
                  schedule_course_helper(Rest, Time, Schedule, Count)
              end;
            false ->
              schedule_course_helper(Rest, Time, Schedule, Count)
          end
      end
  end.