-module(solution).
-export([happy_students/2]).

happy_students(N, Students) ->
    lists:filter(fun(Student) -> Student rem 2 =:= 0 end, Students) ++ 
    lists:filter(fun(Student) -> Student rem 2 =:= 1 end, Students).