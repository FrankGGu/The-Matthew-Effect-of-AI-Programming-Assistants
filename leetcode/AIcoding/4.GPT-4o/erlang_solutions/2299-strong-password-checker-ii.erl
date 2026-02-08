-module(strong_password_checker).
-export([strong_password_checker/1]).

strong_password_checker(Password) ->
    Length = string:length(Password),
    HasLower = has_lower(Password),
    HasUpper = has_upper(Password),
    HasDigit = has_digit(Password),
    HasSpecial = has_special(Password),
    ConditionsMet = length([C || C <- [HasLower, HasUpper, HasDigit, HasSpecial], C]),
    if 
        Length >= 8, 
        ConditionsMet >= 3 -> 
            true;
        true -> 
            false
    end.

has_lower(Password) ->
    lists:any(fun(C) -> C >= $a andalso C =< $z end, string:to_list(Password)).

has_upper(Password) ->
    lists:any(fun(C) -> C >= $A andalso C =< $Z end, string:to_list(Password)).

has_digit(Password) ->
    lists:any(fun(C) -> C >= $0 andalso C =< $9 end, string:to_list(Password)).

has_special(Password) ->
    SpecialChars = "$&+,:;=?@#|'<>.^*()%!-",
    lists:any(fun(C) -> lists:member(C, string:to_list(SpecialChars)) end, string:to_list(Password)).