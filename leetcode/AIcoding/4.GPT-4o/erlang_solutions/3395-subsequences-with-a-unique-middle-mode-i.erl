-module(solution).
-export([unique_middle_mode/1]).

unique_middle_mode(List) ->
    Unique = lists:usort(List),
    lists:foldl(fun(X, Acc) ->
        Count = lists:count(List, X),
        if
            Count rem 2 == 1 -> 
                [X | Acc];
            true -> 
                Acc
        end
    end, [], Unique).