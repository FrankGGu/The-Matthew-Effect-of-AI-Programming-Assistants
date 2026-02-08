-module(solution).
-export([num_students_back_to_school/2]).

num_students_back_to_school(Start, End) ->
    lists:foldl(fun({S, E}, Acc) -> 
        if S >= Start andalso E =< End -> Acc + 1;
           true -> Acc
        end
    end, 0, lists:zip(Start, End)).