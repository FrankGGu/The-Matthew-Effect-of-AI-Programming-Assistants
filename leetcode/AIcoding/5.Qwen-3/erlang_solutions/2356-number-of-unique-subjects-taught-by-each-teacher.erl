-module(leetcode_1562).
-export([find_unique_subjects/1]).

find_unique_subjects(Teachers) ->
    Map = lists:foldl(fun({Teacher, Subject}, Acc) ->
        case maps:find(Teacher, Acc) of
            {ok, Subjects} ->
                maps:put(Teacher, [Subject | Subjects], Acc);
            error ->
                maps:put(Teacher, [Subject], Acc)
        end
    end, #{}, Teachers),
    maps:map(fun(_, Subjects) -> length(Subjects) end, Map).