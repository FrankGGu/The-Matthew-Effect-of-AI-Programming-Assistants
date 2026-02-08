-module(valid_palindrome).
-export([is_palindrome/1]).

is_palindrome(S) ->
    Str = string:lowercase(S),
    Alphanumeric = lists:filter(fun(C) ->
        C >= $a andalso C <= $z orelse C >= $0 andalso C <= $9
    end, string:to_list(Str)),
    Reverse = lists:reverse(Alphanumeric),
    Alphanumeric =/= [] andalso Alphanumeric == Reverse orelse Alphanumeric == [].