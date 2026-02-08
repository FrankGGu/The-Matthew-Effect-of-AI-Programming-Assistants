-module(solution).
-export([find_students/2]).

find_students(Students, StudentsImproved) ->
    lists:filter(fun({Name, OldScore, NewScore}) -> NewScore > OldScore end, Students).