-module(solution).
-export([count_students_unable_to_eat_lunch/2]).

count_students_unable_to_eat_lunch(Students, Sandwiches) ->
    count_students_unable_to_eat_lunch(Students, Sandwiches, 0).

count_students_unable_to_eat_lunch([], _, Count) ->
    Count;
count_students_unable_to_eat_lunch([Student | Rest], Sandwiches, Count) ->
    case lists:member(Student, Sandwiches) of
        true ->
            NewSandwiches = lists:delete(Student, Sandwiches),
            count_students_unable_to_eat_lunch(Rest, NewSandwiches, Count);
        false ->
            count_students_unable_to_eat_lunch(Rest, Sandwiches, Count + 1)
    end.