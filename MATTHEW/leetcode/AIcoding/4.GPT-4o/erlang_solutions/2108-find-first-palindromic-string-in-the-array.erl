-module(solution).
-export([first_palindrome/1]).

first_palindrome(Strs) ->
    lists:foldl(fun(Str, Acc) ->
        case Acc of
            "" -> if is_palindrome(Str) -> Str; true -> Acc end;
            _ -> Acc
        end
    end, "", Strs).

is_palindrome(Str) ->
    Str == lists:reverse(Str).