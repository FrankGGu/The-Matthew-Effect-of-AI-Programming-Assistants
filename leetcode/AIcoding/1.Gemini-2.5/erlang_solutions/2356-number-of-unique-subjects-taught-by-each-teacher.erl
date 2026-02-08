-module(solution).
-export([unique_subjects/1]).

unique_subjects(TeachersSubjects) ->
    TeacherSubjectsMap = lists:foldl(
        fun({TeacherID, SubjectID}, AccMap) ->
            CurrentSubjects = maps:get(TeacherID, AccMap, sets:new()),
            UpdatedSubjects = sets:add_element(SubjectID, CurrentSubjects),
            maps:put(TeacherID, UpdatedSubjects, AccMap)
        end,
        maps:new(),
        TeachersSubjects
    ),
    maps:fold(
        fun(TeacherID, SubjectSet, AccList) ->
            Count = sets:size(SubjectSet),
            [{TeacherID, Count} | AccList]
        end,
        [],
        TeacherSubjectsMap
    ).