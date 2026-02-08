-module(is_palindrome).
-export([is_palindrome/1]).

is_palindrome(S) ->
  NewS = lists:filter(fun(C) -> is_alnum(C) end, string:to_lower(S)),
  NewS == lists:reverse(NewS).

is_alnum(C) ->
  (C >= $a andalso C =< $z) orelse (C >= $0 andalso C =< $9).