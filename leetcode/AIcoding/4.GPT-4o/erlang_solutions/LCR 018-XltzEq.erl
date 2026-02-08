-module(solution).
-export([isPalindrome/1]).

isPalindrome(S) ->
    Cleaned = lists:filter(fun(C) -> C >= $A andalso C =< $Z orelse C >= $a andalso C =< $z orelse C >= $0 andalso C =< $9 end, string:to_upper(S)),
    lists:reverse(Cleaned) =:= Cleaned.