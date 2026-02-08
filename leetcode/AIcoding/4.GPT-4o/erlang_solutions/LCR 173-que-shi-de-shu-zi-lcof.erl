-module(solution).
-export([numStudentsInClass/1]).

numStudentsInClass(Students) ->
    lists:sum(Students).