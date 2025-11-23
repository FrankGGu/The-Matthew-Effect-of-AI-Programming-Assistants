-module(solution).
-export([find_students_who_improved/1]).

find_students_who_improved(Students) ->
    ImprovedIds = [Id || {Id, Score1, Score2} <- Students, Score2 > Score1],
    lists:sort(ImprovedIds).