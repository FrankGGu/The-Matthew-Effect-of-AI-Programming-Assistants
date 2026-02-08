-module(solution).
-export([find_final_value/2]).

find_final_value(List, Original) ->
    FinalValue = lists:foldl(fun(X, Acc) -> if
        X =:= Acc -> Acc * 2;
        true -> Acc
    end, Original, List),
    FinalValue.