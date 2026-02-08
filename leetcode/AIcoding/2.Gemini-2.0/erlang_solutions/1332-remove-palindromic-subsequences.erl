-module(remove_palindromic_subsequences).
-export([remove_palindrome_subsequences/1]).

is_palindrome(S) ->
  String = list_to_binary(S),
  BinaryReverse = list_to_binary(lists:reverse(S)),
  String =:= BinaryReverse.

remove_palindrome_subsequences(S) ->
  case S of
    [] ->
      0;
    _ ->
      if
        is_palindrome(S) ->
          1;
        true ->
          2
      end
  end.