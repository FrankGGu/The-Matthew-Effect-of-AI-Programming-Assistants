-module(first_palindrome).
-export([first_palindrome/1]).

first_palindrome(Words) ->
  lists:foldl(
    fun(Word, Acc) ->
      case is_palindrome(Word) of
        true ->
          case Acc of
            "" -> Word;
            _ -> Acc
          end;
        false ->
          Acc
      end
    end,
    "",
    Words
  ).

is_palindrome(Word) ->
  Word == lists:reverse(Word).