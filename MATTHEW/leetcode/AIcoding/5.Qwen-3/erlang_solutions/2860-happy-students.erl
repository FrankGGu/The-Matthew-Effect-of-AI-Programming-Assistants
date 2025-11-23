-module(happy_students).
-export([is_happy/1]).

is_happy(Students) ->
    is_happy(Students, 0, dict:new()).

is_happy([], _, _) ->
    true;
is_happy([Student | Rest], Index, Seen) ->
    case dict:find(Student, Seen) of
        {ok, PrevIndex} when PrevIndex < Index ->
            is_happy(Rest, Index + 1, dict:store(Student, Index, Seen));
        _ ->
            false
    end.