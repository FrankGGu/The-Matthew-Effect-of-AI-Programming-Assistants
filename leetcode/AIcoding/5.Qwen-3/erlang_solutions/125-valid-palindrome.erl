-module(valid_palindrome).
-export([is_palindrome/1]).

is_palindrome(S) ->
    Clean = lists:filter(fun(C) -> (C >= $a andalso C =< $z) orelse (C >= $0 andalso C =< $9) end, S),
    lists:reverse(Clean) == Clean.