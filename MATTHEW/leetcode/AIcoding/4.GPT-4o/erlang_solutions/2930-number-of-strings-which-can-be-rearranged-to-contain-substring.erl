-module(solution).
-export([num_of_strings/2]).

num_of_strings(Strs, Sub) ->
    Count = lists:foldl(fun(S, Acc) -> 
        if 
            can_form(S, Sub) -> Acc + 1; 
            true -> Acc 
        end 
    end, 0, Strs),
    Count.

can_form(Str, Sub) ->
    lists:all(fun(C) -> 
        count_char(Str, C) >= count_char(Sub, C) 
    end, lists:usort(lists:chars(Sub))).

count_char(Str, Char) ->
    lists:foldl(fun(X, Acc) -> 
        if 
            X == Char -> Acc + 1; 
            true -> Acc 
        end 
    end, 0, Str).