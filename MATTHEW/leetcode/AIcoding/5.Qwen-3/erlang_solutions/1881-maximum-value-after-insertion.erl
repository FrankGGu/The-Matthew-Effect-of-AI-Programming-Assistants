-module(max_value_after_insertion).
-export([maxValue/1]).

maxValue(Num) ->
    Max = 0,
    List = string:to_list(Num),
    Length = length(List),
    lists:foldl(fun(I, Acc) ->
        case I of
            _ when I < $9 ->
                NewList = lists:sublist(List, I) ++ [$9] ++ lists:sublist(List, I+1, Length - I),
                NumStr = lists:flatten(NewList),
                erlang:list_to_integer(NumStr);
            _ ->
                Acc
        end
    end, Max, lists:seq(0, Length-1)).