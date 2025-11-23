-module(password_checker).
-export([strongPasswordChecker/1]).

strongPasswordChecker(Password) ->
    Length = erlang:length(Password),
    has_lower = lists:any(fun(C) -> C >= $a andalso C =< $z end, Password),
    has_upper = lists:any(fun(C) -> C >= $A andalso C =< $Z end, Password),
    has_digit = lists:any(fun(C) -> C >= $0 andalso C =< $9 end, Password),
    has_special = lists:any(fun(C) -> lists:member(C, [33, 64, 35, 36, 37, 94, 38, 42, 40, 41, 45, 95]) end, Password),
    has_repeating = lists:member(true, [true || [A,B,C,D,E] <- lists:splitlist(5, Password), A == B, B == C, C == D, D == E]),
    if
        Length >= 6, has_lower, has_upper, has_digit, has_special, not has_repeating -> 1;
        true -> 0
    end.