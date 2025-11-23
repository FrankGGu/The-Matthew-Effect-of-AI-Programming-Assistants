-module(solution).
-export([count_seniors/1]).

count_seniors(P) ->
    lists:foldl(fun(Person, Acc) ->
        AgeStr = lists:sublist(Person, 11, 2),
        Age = list_to_integer(AgeStr),
        if 
            Age > 60 -> Acc + 1;
            true -> Acc
        end
    end, 0, P).