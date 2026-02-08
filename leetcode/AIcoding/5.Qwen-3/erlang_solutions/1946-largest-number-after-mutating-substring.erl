-module(largest_number_after_mutating_substring).
-export([max_number/2]).

max_number(Number, Sub) ->
    List = erl_string:to_list(Number),
    Length = length(List),
    Max = lists:foldl(fun(I, Acc) ->
        case I + length(Sub) =< Length of
            true ->
                SubList = lists:sublist(List, I+1, length(Sub)),
                if SubList == Sub -> 
                    NewList = lists:sublist(List, 1, I) ++ lists:reverse(Sub) ++ lists:sublist(List, I+length(Sub)+1),
                    Current = list_to_integer(lists:flatten([integer_to_list(C) || C <- NewList])),
                    max(Acc, Current);
                true -> Acc
                end;
            false -> Acc
        end
    end, -1, lists:seq(0, Length-1)),

    if Max == -1 -> Number; true -> integer_to_list(Max) end.