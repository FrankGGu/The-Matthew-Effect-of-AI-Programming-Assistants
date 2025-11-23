-module(find_students_who_improved).
-export([find_students/1]).

find_students(Students) ->
    lists:filter(fun(Student) -> 
        [Name, OldScore, NewScore] = Student,
        NewScore > OldScore
    end, Students).