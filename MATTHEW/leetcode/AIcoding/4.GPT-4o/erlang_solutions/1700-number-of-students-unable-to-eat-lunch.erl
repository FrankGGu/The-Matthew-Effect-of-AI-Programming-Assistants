-module(solution).
-export([countStudents/2]).

countStudents(Students, Sandwiches) ->
    count_students(Students, Sandwiches, 0).

count_students([], _, Count) -> Count;
count_students(_, [], Count) -> Count;
count_students(Students, [Top | Rest], Count) ->
    case lists:member(Top, Students) of
        true ->
            NewStudents = lists:filter(fun(X) -> X /= Top end, Students),
            count_students(NewStudents, Rest, Count);
        false ->
            count_students(Students, Rest, Count + 1)
    end.