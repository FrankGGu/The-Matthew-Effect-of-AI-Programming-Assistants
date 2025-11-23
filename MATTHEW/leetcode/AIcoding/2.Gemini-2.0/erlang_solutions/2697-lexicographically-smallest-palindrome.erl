-module(lexicographically_smallest_palindrome).
-export([make_smallest_palindrome/1]).

make_smallest_palindrome(S) ->
  make_smallest_palindrome(S, 1, length(S)).

make_smallest_palindrome(S, L, R) when L >= R ->
  S;
make_smallest_palindrome(S, L, R) ->
  CharL = string:substr(S, L, 1),
  CharR = string:substr(S, R, 1),
  if
    CharL == CharR ->
      make_smallest_palindrome(S, L + 1, R - 1);
    CharL < CharR ->
      NewS = string:replace(S, R, 1, CharL),
      make_smallest_palindrome(NewS, L + 1, R - 1);
    true ->
      NewS = string:replace(S, L, 1, CharR),
      make_smallest_palindrome(NewS, L + 1, R - 1)
  end.